<script setup>
  import ApexChartRealtime from '@/views/charts/apex-chart/ApexChartRealtime.vue'

  var lastDate = new Date().getTime()
  const lastData = ref(0)
  const maxData = ref(0)
  const totalData = ref(0)

  const series = ref([])
  const animate = ref(true)

  const getNewSeries = (baseval, yrange) => {
    var newDate = new Date().getTime()
    lastDate = newDate

    lastData.value = Math.floor(Math.random() * (yrange.max - yrange.min + 1)) + yrange.min
    if (maxData.value < lastData.value) maxData.value = lastData.value

    totalData.value = totalData.value + lastData.value
    series.value.push({
      x: newDate,
      y: lastData.value
    })

    //console.log(JSON.stringify(series.value))
  }


  const resetData = () => {

    //data.value = data.value.slice(data.value.length - 10, data.value.length);
    data.value = data.value.slice(data.value.length - 60, data.value.length);

  }


  onMounted(() => {
    setInterval(() => {
      animate.value = true
      getNewSeries(lastDate, {
        min: 10,
        max: 90
      })
    }, 1000);

    setInterval(() => {
      //resetData();
      resetData()

    }, 122000);
  })

</script>

<template>
  <VRow id="apex-chart-wrapper">
    <!-- 👉 Balance Line Chart  -->
    <VCol cols="12">
      <VCard>
        <v-container class="d-flex flex-wrap justify-space-between gap-4 p-b-0">
          <v-row no-gutters>
            <v-col cols="12" sm="4" align="left">
              <v-sheet>

                <VCardItem class="d-flex flex-wrap justify-space-between gap-4">
                  <VCardTitle>实时用户</VCardTitle>
                  <VCardSubtitle>一分钟内实时用户数据</VCardSubtitle>
                </VCardItem>

              </v-sheet>
            </v-col>

            <v-col cols="12" sm="4" align="center" class="p-t-15">
              <v-sheet>
                <VIcon start icon="tabler-users-group" size="30" />
                <h1 class="text-h1">{{ totalData }}</h1>

              </v-sheet>
            </v-col>

            <v-col cols="12" sm="4" align="right">
              <v-sheet>
                <VCardItem>
                  <template #append>
                    <div></div>
                    <div class="d-flex align-center">
                      <h6 class="text-h6 me-3">
                        {{ lastData }}
                      </h6>
                      <VChip label color="success">
                        <VIcon start icon="tabler-users" size="15" />
                        <span>{{ maxData }}</span>
                      </VChip>
                    </div>
                  </template>
                </VCardItem>
              </v-sheet>
            </v-col>
          </v-row>
        </v-container>
        
        <VCardText class="p-t-0">
          <ApexChartRealtime :series="series" :animate="animate" />
        </VCardText>
      </VCard>
    </VCol>
  </VRow>
</template>

<style lang="scss">
  @use "@core/scss/template/libs/apex-chart.scss";

  .date-picker-wrapper {
    inline-size: 10.5rem;
  }

  #apex-chart-wrapper {
    .v-card-item__append {
      padding-inline-start: 0;
    }
  }
</style>
