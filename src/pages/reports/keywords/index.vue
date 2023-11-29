<script setup>
  import {VDataTable} from 'vuetify/labs/VDataTable'
  import {paginationMeta} from '@/@fake-db/utils'
  import {useReportStore} from '@/views/reports/useReportStore'
  import {avatarText} from '@core/utils/formatters'
  import {activeVariant} from '@/views/components/status/activeVariant'
  import AddNewKeywordsDrawer from '@/views/reports/AddNewKeywordsDrawer.vue'
  import EditKeywordsDrawer from '@/views/reports/EditKeywordsDrawer.vue'

  import {useImStore} from '@/views/im/useImStore'

  import msgJson from '@/views/components/dialogs/msg.json'

  let imData = ref(JSON.parse(localStorage.getItem('userData')))

  const imStore = useImStore()

  const reportStore = useReportStore()

  const searchQuery = ref('')

  const perPage = ref(10)
  const page = ref(0)

  const existGroup = ref(true)

  const keywordsTotal = ref('')

  const options = ref({
    page: page.value,
    itemsPerPage: perPage.value,
    sortBy: [],
    groupBy: [],
    search: undefined,
  })

  const projects = ref([])

  const keywords = ref([])

  const isAddNewKeywordsDrawerVisible = ref(false)
  const isEditKeywordsDrawerVisible = ref(false)
  const keywordsData = ref({})

  // 👉 headers
  const headers = [
    {
      title: '关键词',
      key: 'keywords',
    },
    {
      title: '添加人',
      key: 'name',
    },
    {
      title: '激活',
      key: 'active',
    },
    {
      title: '时间',
      key: 'updated_at',
    },
    {
      title: 'Active',
      key: 'id',
      sortable: false,

    },
    {
      title: '',
      key: 'created_at',
      sortable: false,
    }

  ]



  // 👉 Fetch Projects
  onMounted(() => {
    getItem(page.value)
  })

  const getItem = (to) => {
    reportStore.fetchReportKeywords(perPage.value, to).then(response => {
      keywords.value = response.data.data.data
      perPage.value = response.data.data.per_page
      keywordsTotal.value = response.data.data.total

    }).catch(error => {
      console.log(error.response)
    })
  }

  const onPageChange = (i) => {
    page.value = i
    getItem(i)
  }

  const deleted = (n, keywords) => {
    reportStore.deleteKeywords(keywords).then(response => {

      getItem(page.value)
      toast.success(response.data.message,{
        position: "top-center"
      })
    }).catch(error => {
      console.log("ERROR: " + JSON.stringify(error))
    })

    

  }

  const active = (id, value) => {
    reportStore.updateKeywords({id: id, active: value}).then(response => {
    }).catch(error => {
      toast.error(error.response.data.message, {
        position: "top-center"
      })
    })
  }

  const addNewKeywords = keywords => {
    reportStore.addNewKeywords(keywords).then(response => {
      getItem(page.value)

      toast.success(response.data.message, {
        position: "top-center"
      })
    }).catch(error => {
      console.log("ERROR: " + JSON.stringify(error))
    })
  }

  const editKeywords = keywords => {
    reportStore.editKeywords(keywords).then(response => {

      getItem(page.value)

      toast.success(response.data.message, {
        position: "top-center"
      })
    }).catch(error => {
      toast.error(error.response.data.message, {
        position: "top-center"
      })
    })

  }
  
  const isEdit = item => {
    isEditKeywordsDrawerVisible.value = true
    keywordsData.value = item
  }



</script>

<template>
  <section>
    <VRow>
      <VCol>

        <VCard v-if="keywords">
          <VCardItem class="project-header d-flex flex-wrap justify-space-between py-4 gap-4">
            <VCardTitle>{{ $t('Keywords')}}</VCardTitle>

            <template #append>
              <div class="app-user-search-filter d-flex align-center flex-wrap gap-4">
                <!-- 👉 Search  -->
                <div style="inline-size: 10rem;">
                  <AppTextField v-model="searchQuery" placeholder="Search" density="compact" />
                </div>

                <!-- 👉 Add user button -->
                <VBtn prepend-icon="tabler-plus" @click="isAddNewKeywordsDrawerVisible = true">
                  增加关键词
                </VBtn>
              </div>
            </template>
          </VCardItem>

          <VDivider />

          <!-- SECTION Table -->
          <VDataTable v-model:items="keywords" :items-per-page=perPage show-select :search="searchQuery"
            :headers="headers" :items="keywords" v-model="keywords" class="text-no-wrap"
            @update:options="options = $event" ref="table">

            <!-- 👉 name -->
            <template #item.keywords="{ item }">
              <div class="d-flex align-center gap-4">
                <span>{{ item.raw.keywords }}</span>
              </div>
            </template>

            <template #item.name="{ item }">
              <div class="d-flex align-center gap-4">
                <span class="text-capitalize">{{ item.raw.name }}</span>
              </div>
            </template>

            <template #item.active="{ item }">
              <VChip :color="activeVariant(item.raw.active).color" size="small" label class="text-capitalize">
                {{ activeVariant(item.raw.active).text }}
              </VChip>
            </template>


            <template #item.updated_at="{ item }">
              <div class="d-flex align-center gap-4">
                <span class="text-capitalize">{{ item.raw.updated_at }}</span>
              </div>
            </template>


            <!-- 👉 Actions -->
            <template #item.id="{ item }">

              <VSwitch v-model="item.raw.active" @change="active(item.raw.id, item.raw.active)" :true-value="1"
                :false-value="0" />

            </template>


            <template #item.created_at="{ item }">

              <IconPersistent :msg="msgJson.deleted" :item="item.raw" @vclick="deleted" />

              <IconBtn>
                <VIcon icon="tabler-edit"  @click="isEdit(item.raw)"/>
              </IconBtn>
            </template>




            <template #bottom>
              <VDivider />

              <div class="d-flex align-center justify-center justify-sm-space-between flex-wrap gap-3 pa-5 pt-3">
                <p class="text-sm text-disabled mb-0">
                  {{ paginationMeta(options, keywordsTotal) }}
                </p>

                <VPagination v-model="options.page" :total-visible="7"
                  :length="Math.ceil(keywordsTotal / options.itemsPerPage)"
                  @update:model-value="onPageChange(options.page)">
                  <template #next="slotProps">
                    <VBtn v-bind="slotProps" :icon="false" variant="tonal" color="default">
                      Next
                    </VBtn>
                  </template>

                  <template #prev="slotProps">
                    <VBtn v-bind="slotProps" :icon="false" variant="tonal" color="default">
                      Previous
                    </VBtn>
                  </template>
                </VPagination>
              </div>
            </template>
          </VDataTable>
          <!-- !SECTION -->
        </VCard>
        <!-- 👉 Add New User -->
        <AddNewKeywordsDrawer v-model:isDrawerOpen="isAddNewKeywordsDrawerVisible" @addNewKeywords="addNewKeywords" />

        <EditKeywordsDrawer v-model:isDrawerOpen="isEditKeywordsDrawerVisible" :keywordsData="keywordsData" @editKeywords="editKeywords" />

      </VCol>
    </VRow>
  </section>

</template>

<style lang="scss">
  .project-header .v-card-item__append {
    padding-inline-start: 0;
  }
</style>
