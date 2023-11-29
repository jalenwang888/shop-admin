<script setup>
  import {VDataTable} from 'vuetify/labs/VDataTable'
  import {paginationMeta} from '@/@fake-db/utils'
  import {useReportStore} from '@/views/reports/useReportStore'
  import {avatarText} from '@core/utils/formatters'
  import {statusVariant} from '@/views/components/status/statusVariant'

  import {useImStore} from '@/views/im/useImStore'

  import msgJson from '@/views/components/dialogs/msg.json'

  let imData = ref(JSON.parse(localStorage.getItem('userData')))

  const status = ref(null)
  const limit = ref(10)

  const props = defineProps(['status', 'limit'])



  const imStore = useImStore()

  const reportStore = useReportStore()

  const searchQuery = ref('')

  const perPage = ref(10)
  const page = ref(0)


  if(props.status)
    status.value = props.status

  if(props.limit)
    perPage.value = props.limit

  const existGroup = ref(true)

  const reportsTotal = ref('')

  const options = ref({
    page: page.value,
    itemsPerPage: perPage.value,
    sortBy: [],
    groupBy: [],
    search: undefined,
  })

  const projects = ref([])

  const reports = ref([])


  // 👉 headers
  const headers = [
    {
      title: 'Whistleblower',
      key: 'user_id',
    },
    {
      title: 'Reported person',
      key: 'report_user_id',
    },
    {
      title: 'Type',
      key: 'report_type',
    },
    {
      title: 'Group Id',
      key: 'group_id',
    },
    {
      title: 'Message',
      key: 'message',
    },
    {
      title: 'Time',
      key: 'message_time',
    },
    {
      title: 'Status',
      key: 'status',
    },
    {
      title: 'Actions',
      key: 'actions',
      sortable: false,
    },
  ]


  // 👉 Fetch Projects
  onMounted(() => {
    getItem(page.value)
  })

  const getItem = (to) => {
    console.log("status:" + status.value)
    reportStore.fetchReports(perPage.value, to, status.value).then(response => {

      reports.value = response.data.data.data
      perPage.value = response.data.data.per_page
      reportsTotal.value = response.data.data.total

    }).catch(error => {
      console.log(error.response)
    })
  }

  const onPageChange = (i) => {
    page.value = i
    getItem(i)
  }

  const computedMoreList = computed(() => {
    return paramId => [
      {
        title: '停用账号',
        value: 'inactive',
        prependIcon: 'tabler-user-off',
        to: {
          name: 'reports-view-id',
          params: {id: paramId},
        },
      },
    ]
  })

  const vclick = (n, report) => {
    console.log("N: " + JSON.stringify(n))
    imStore.joinGroup(report.group_id).then(response => {

      let msgData = {
        "GroupId": report.group_id,
        "Content": "@" + report.user_nick + " " + n.content,
        "atUserList": [report.user_id]
      }

      if (n.status === "warn") {
        imStore.sendAtMsg(msgData).then(response => {
          console.log("reportData: " + JSON.stringify(report))
        }).catch(error => {
          toast.error(error.message, {
            position: "top-right"
          })
        })
      }


      if (n.status === "stopSpeaker") {
        imStore.stopSpeaker(report.user_id)
          .then(response => {
            console.log("stopSpeaker: " + JSON.stringify(response.data))
          }).catch(error => {
            toast.error(error.message, {
              position: "top-right"
            })
          })
      }

    }).catch(error => {
      console.log("JOIN ERROR: " + JSON.stringify(error))

    })

    //console.log("GROUP: " + existGroup.value)

    //更新数据库
    report.status = n.status

    report.operator = imData.value.imAdmin.userId
    console.log("imData" + JSON.stringify(imData.value))
    reportStore.updateReport(report).then(response => {
      console.log(JSON.stringify(response))
      toast.success(response.data.message, {
        position: "top-center"
      })
    }).catch(error => {
      console.log("ERROR: " + JSON.stringify(error))
    })
  }

</script>

<template>
  <VCard v-if="reports">
    <VCardItem class="project-header d-flex flex-wrap justify-space-between py-4 gap-4">
      <VCardTitle>{{ $t('Reports')}}</VCardTitle>

      <template #append>
        <div style="inline-size: 272px;">
          <AppTextField v-model="searchQuery" placeholder="Search" />
        </div>
      </template>
    </VCardItem>

    <VDivider />

    <!-- SECTION Table -->
    <VDataTable v-model:items="reports" :items-per-page=perPage show-select :search="searchQuery" :headers="headers"
      :items="reports" v-model="reports" class="text-no-wrap" @update:options="options = $event" ref="table">

      <!-- 👉 name -->
      <template #item.user_id="{ item }">
        <div class="d-flex align-center gap-4">
          <RouterLink :to="{ name: 'reports-view-id', params: { id: item.raw.id } }"
            class="font-weight-medium user-list-name">
            <span class="text-capitalize">#{{ item.raw.id }}: {{ item.raw.user_id }}</span>
          </RouterLink>


        </div>
      </template>
      <template #item.report_user_id="{ item }">
        <div class="d-flex align-center gap-4">
          <span class="text-capitalize">{{ item.raw.report_user_id }}</span>
        </div>
      </template>

      <template #item.report_type="{ item }">
        <div class="d-flex align-center gap-4">
          <span class="text-capitalize">{{ item.raw.report_type }}</span>
        </div>
      </template>

      <template #item.group_id="{ item }">
        <div class="d-flex align-center gap-4">
          <span class="text-capitalize">{{ item.raw.group_id }}</span>
        </div>
      </template>

      <template #item.message="{ item }">
        <div class="d-flex align-center gap-4">
          <span class="text-capitalize">{{ item.raw.message }}</span>
        </div>
      </template>

      <template #item.message_time="{ item }">
        <div class="d-flex align-center gap-4">
          <span class="text-capitalize">{{ item.raw.message_time }}</span>
        </div>
      </template>

      <template #item.status="{ item }">
        <VChip :color="statusVariant(item.raw.status)" size="small" label class="text-capitalize">
          {{ item.raw.status }}
        </VChip>
      </template>


      <!-- 👉 Actions -->
      <template #item.actions="{ item }">

        <IconPersistent :msg="msgJson.reportWarn" :item="item.raw" @vclick="vclick" />

        <IconPersistent :msg="msgJson.reportStopSpeaker" :item="item.raw" @vclick="vclick" />

        <MoreBtn color="default" :menu-list="computedMoreList(item.raw.id)" item-props />
      </template>

      <template #bottom>
        <VDivider />

        <div class="d-flex align-center justify-center justify-sm-space-between flex-wrap gap-3 pa-5 pt-3">
          <p class="text-sm text-disabled mb-0">
            {{ paginationMeta(options, reportsTotal) }}
          </p>

          <VPagination v-model="options.page" :total-visible="7"
            :length="Math.ceil(reportsTotal / options.itemsPerPage)" @update:model-value="onPageChange(options.page)">
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
</template>

<style lang="scss">
  .project-header .v-card-item__append {
    padding-inline-start: 0;
  }
</style>
