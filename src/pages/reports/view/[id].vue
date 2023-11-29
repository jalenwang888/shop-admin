<script setup>
  import {useReportStore} from '@/views/reports/useReportStore'
  import {useImStore} from '@/views/im/useImStore'
  import {statusVariant} from '@/views/components/status/statusVariant'


  import msgJson from '@/views/components/dialogs/msg.json'

  const reportStore = useReportStore()
  const imStore = useImStore()

  const route = useRoute()

  const reportData = ref({})
  const historyData = ref({})
  const userData = ref([])
  const errors = ref()

  const status = ref("new")

  let imData = ref(JSON.parse(localStorage.getItem('userData')))

  const vclick = (n) => {
    console.log("N: " + JSON.stringify(n))
    imStore.joinGroup(reportData.value.group_id).then(response => {

      let msgData = {
        "GroupId": reportData.value.group_id,
        "Content": "@" + reportData.value.user_nick + " " + n.content,
        "atUserList": [reportData.value.user_id]
      }
      imStore.sendAtMsg(msgData).then(response => {
        console.log("reportData: " + JSON.stringify(reportData.value))
      }).catch(error => {
        toast.error(error.message);
      })

    }).catch(error => {
      toast.error(error.message);
    })


    if (n.status === "stopSpeaker") {
      imStore.stopSpeaker(reportData.value.user_id)
      .then(response => { 
        console.log("stopSpeaker: " + JSON.stringify(response.data))
      }).catch(error => {
        toast.error(error.message);
      })
    }

    //更新数据库
    reportData.value.status = n.status
    reportData.value.operator = imData.value.imAdmin.userId
    reportStore.updateReport(reportData.value).then(response => {
      console.log("update: " + JSON.stringify(response.data))
    }).catch(error => {
      console.log("ERROR: " + JSON.stringify(error.response))
    })

  }


  // 👉 Fetch Projects
  onMounted(() => {
    reportStore.fetchReport(Number(route.params.id)).then(response => {
      reportData.value = response.data.reportData
      historyData.value = response.data.historyData
      userData.value = response.data.userData

      var arr = Object.keys(reportData.value)

      imStore.login(imData.value.imAdmin)

    }).catch(error => {

      const {error: formError} = error.response.data

      errors.value = formError
      console.error(error.response.data)
    })
  })

  watch(() => route.path, () => {
    console.log('来自：' + route.path)

  }, {immediate: true})



</script>
<template>
  <section>
    <VRow v-if="errors">
      <VCol cols="12">
        <!-- 👉 Link -->
        <VAlert color="warning" variant="tonal">
          <VAlertTitle class="mb-1">
            {{ $t("Error")}}
          </VAlertTitle>

          <span>{{ errors }}</span>
        </VAlert>
      </VCol>
    </VRow>

    <VRow v-if="Object.keys(reportData).length > 0">
      <VCol cols="12" md="10">
        <VCard>
          <!-- SECTION Header -->
          <VCardText class="d-flex flex-wrap justify-space-between flex-column flex-sm-row print-row">
            <!-- 👉 Left Content -->
            <div class="ma-sm-4">
              <div class="d-flex align-center mb-6">
                <!-- 👉 Title -->
                <h6 class="font-weight-bold text-capitalize text-h4">
                  被举报人
                </h6>
              </div>

              <p>
                <span class="m-r-10">#{{ reportData.id}}</span>


                <VChip :color="statusVariant(reportData.report_type)" size="small" label
                  class="text-capitalize m-r-10">
                  {{ reportData.report_type}}
                </VChip>

                <VChip :color="statusVariant(reportData.status)" size="small" label class="text-capitalize">
                  {{ reportData.status}}
                </VChip>
              </p>

              <p class="mb-0">
                {{ reportData.user_id}}
              </p>
              <p class="my-2">
                {{ reportData.group_id}}
              </p>
              <p class="mb-0">
                {{ reportData.created_at}}
              </p>
            </div>

            <!-- 👉 Right Content -->
            <div class="mt-4 ma-sm-4">
              <!-- 👉 Invoice ID -->
              <h6 class="font-weight-medium text-h4">
                举报人
              </h6>

              <p class="my-3">
                <!--<span>Date Issued: </span> -->
                <span class="font-weight-medium"> {{ reportData.report_user_id}}</span>
              </p>
            </div>
          </VCardText>
          <!-- !SECTION -->

          <VDivider />

          <!-- 👉 Payment Details -->
          <VCardText class="d-flex justify-space-between flex-wrap flex-column flex-sm-row print-row">
            <div class="ma-sm-4">
              <h6 class="text-base font-weight-medium mb-6">
                内容:
              </h6>
              <div class="mb-1">
                {{ reportData.message }}
              </div>
            </div>

          </VCardText>

          <!-- 👉 Table -->
          <VDivider />

          <VTable class="invoice-preview-table">
            <thead>
              <tr>
                <th scope="col">
                  ID
                </th>
                <th scope="col">
                  举报人
                </th>
                <th scope="col">
                  举报类型
                </th>
                <th scope="col" class="text-center">
                  聊天室
                </th>
                <th scope="col" class="text-center">
                  内容
                </th>
                <th scope="col" class="text-center">
                  时间
                </th>
                <th scope="col" class="text-center">
                  状态
                </th>
              </tr>
            </thead>

            <tbody>

              <tr v-for="item in historyData" :key="item.id">
                <td class="text-no-wrap">
                  <RouterLink :to="{ name: 'reports-view-id', params: { id:  item.id } }"
                    class="font-weight-medium user-list-name">
                    <span class="text-capitalize">#{{ item.id }}</span>
                  </RouterLink>
                  <router-view :key="$route.fullPath" />
                </td>
                <td class="text-no-wrap">
                  {{ item.report_user_id }}
                </td>
                <td class="text-no-wrap">
                  <VChip :color="statusVariant(item.report_type)" size="small" label
                    class="text-capitalize m-r-10">
                    {{ item.report_type}}
                  </VChip>
                </td>
                <td class="text-center">
                  {{ item.group_id }}
                </td>
                <td>
                  {{ item.message }}
                </td>
                <td class="text-center">
                  {{ item.created_at }}
                </td>
                <td class="text-center">
                  <VChip :color="statusVariant(item.status)" size="small" label class="text-capitalize">
                    {{ item.status}}
                  </VChip>
                </td>
              </tr>
            </tbody>
          </VTable>

          <VDivider class="mb-2" />

          <VCardText>
            <div class="d-flex mx-sm-4">
              <h6 class="text-base font-weight-medium me-1">
                注意:
              </h6>
              <span>被举报的历史记录</span>
            </div>
          </VCardText>
        </VCard>
      </VCol>

      <VCol cols="12" md="2" class="d-print-none">
        <VCard>
          <VCardText>

            <Persistent :msg="msgJson.reportWarn" @vclick="vclick" />

            <Persistent :msg="msgJson.reportStopSpeaker" @vclick="vclick" />

            <VBtn block variant="tonal" color="secondary" class="mb-2">
              停用账号
            </VBtn>
          </VCardText>
        </VCard>
      </VCol>
    </VRow>
  </section>

</template>

<style lang="scss">
  .invoice-preview-table {
    --v-table-row-height: 44px !important;
  }

  @media print {
    .v-application {
      background: none !important;
    }

    @page {
      margin: 0;
      size: auto;
    }

    .layout-page-content,
    .v-row,
    .v-col-md-9 {
      padding: 0;
      margin: 0;
    }

    .product-buy-now {
      display: none;
    }

    .v-navigation-drawer,
    .layout-vertical-nav,
    .app-customizer-toggler,
    .layout-footer,
    .layout-navbar,
    .layout-navbar-and-nav-container {
      display: none;
    }

    .v-card {
      box-shadow: none !important;

      .print-row {
        flex-direction: row !important;
      }
    }

    .layout-content-wrapper {
      padding-inline-start: 0 !important;
    }
  }
</style>
