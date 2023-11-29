<script setup>
  import {VDataTable} from 'vuetify/labs/VDataTable'
  import {paginationMeta} from '@/@fake-db/utils'
  import {useChatGroupStore} from '@/views/apps/chat/useChatGroupStore'
  import {avatarText} from '@core/utils/formatters'
  import {statusVariant} from '@/views/components/status/statusVariant'

  import {useImStore} from '@/views/im/useImStore'

  import msgJson from '@/views/components/dialogs/msg.json'

  let imData = ref(JSON.parse(localStorage.getItem('userData')))

  const status = ref(null)
  const limit = ref(10)

  const props = defineProps(['status', 'limit'])



  const imStore = useImStore()

  const chatGroupStore = useChatGroupStore()

  const searchQuery = ref('')

  const perPage = ref(10)
  const page = ref(0)


  if(props.status)
    status.value = props.status

  if(props.limit)
    perPage.value = props.limit

  const existGroup = ref(true)

  const groupsTotal = ref('')

  const options = ref({
    page: page.value,
    itemsPerPage: perPage.value,
    sortBy: [],
    groupBy: [],
    search: undefined,
  })

  const projects = ref([])

  const groups = ref([])


  // 👉 headers
  const headers = [
    {
      title: 'ID',
      key: 'id',
    },
    {
      title: 'group id',
      key: 'group_id',
    },
    {
      title: 'introduction',
      key: 'introduction',
    },
    {
      title: 'notification',
      key: 'notification',
    },
    {
      title: 'group_name',
      key: 'group_name',
    },
    {
      title: 'group_type',
      key: 'group_type',
    },
    {
      title: 'website',
      key: 'website',
    },
    {
      title: 'member_num',
      key: 'member_num',
    },
    {
      title: 'active',
      key: 'active',
    },
    {
      title: 'created_at',
      key: 'created_at',
    },
  ]


  // 👉 Fetch Projects
  onMounted(() => {
    getItem(page.value)
  })

  const getItem = (to) => {
    console.log("status:" + status.value)
    chatGroupStore.fetchChatGroup(perPage.value, to, status.value).then(response => {

      groups.value = response.data.data.data
      perPage.value = response.data.data.per_page
      groupsTotal.value = response.data.data.total

      console.log(JSON.stringify(response.data))

    }).catch(error => {
      console.log(error.response)
    })
  }

  const onPageChange = (i) => {
    page.value = i
    getItem(i)
  }



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
    chatGroupStore.updateReport(report).then(response => {
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
  <VCard v-if="groups">
    <VCardItem class="project-header d-flex flex-wrap justify-space-between py-4 gap-4">
      <VCardTitle>{{ $t('Chat List')}}</VCardTitle>

      <template #append>
        <div style="inline-size: 272px;">
          <AppTextField v-model="searchQuery" placeholder="Search" />
        </div>
      </template>
    </VCardItem>

    <VDivider />

    <!-- SECTION Table -->
    <VDataTable v-model:items="groups" :items-per-page=perPage :search="searchQuery" :headers="headers"
      :items="groups" v-model="groups" class="text-no-wrap" @update:options="options = $event" ref="table">

     

      <template #bottom>
        <VDivider />

        <div class="d-flex align-center justify-center justify-sm-space-between flex-wrap gap-3 pa-5 pt-3">
          <p class="text-sm text-disabled mb-0">
            {{ paginationMeta(options, groupsTotal) }}
          </p>

          <VPagination v-model="options.page" :total-visible="7"
            :length="Math.ceil(groupsTotal / options.itemsPerPage)" @update:model-value="onPageChange(options.page)">
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
