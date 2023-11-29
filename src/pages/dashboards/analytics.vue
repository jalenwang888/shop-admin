<script setup>
  import {useTheme} from 'vuetify'
  
  import AnalyticsWebsiteAnalytics from '@/views/dashboards/analytics/AnalyticsWebsiteAnalytics.vue'
  import AnalyticsSalesOverview from '@/views/dashboards/analytics/AnalyticsSalesOverview.vue'
  //import AnalyticsReportTable from '@/views/dashboards/analytics/AnalyticsReportTable.vue'
  import AnalyticsReportTable from '@/pages/reports/list/index.vue'
  const vuetifyTheme = useTheme()
  const currentTheme = vuetifyTheme.current.value.colors

  const status = ref('new')
  const limit = ref(5)

  const statisticsVertical = {
    title: 'Revenue Generated',
    color: 'success',
    icon: 'tabler-credit-card',
    stats: '97.5k',
    height: 97,
    series: [{
      data: [
        300,
        350,
        330,
        380,
        340,
        400,
        380,
      ],
    }],
    chartOptions: {
      chart: {
        height: 110,
        type: 'area',
        parentHeightOffset: 0,
        toolbar: {show: false},
        sparkline: {enabled: true},
      },
      tooltip: {enabled: false},
      markers: {
        colors: 'transparent',
        strokeColors: 'transparent',
      },
      grid: {show: false},
      colors: [currentTheme.success],
      fill: {
        type: 'gradient',
        gradient: {
          shadeIntensity: 0.8,
          opacityFrom: 0.6,
          opacityTo: 0.1,
        },
      },
      dataLabels: {enabled: false},
      stroke: {
        width: 2,
        curve: 'smooth',
      },
      xaxis: {
        show: true,
        lines: {show: false},
        labels: {show: false},
        stroke: {width: 0},
        axisBorder: {show: false},
      },
      yaxis: {
        stroke: {width: 0},
        show: false,
      },
    },
  }

</script>

<template>
  <VRow class="match-height">
    <!-- 👉 Website analytics -->
    <VCol cols="12" md="6">
      <AnalyticsWebsiteAnalytics />
    </VCol>


    <!-- 👉 Statistics Vertical -->
    <VCol cols="12" md="6" sm="6">
      <CardStatisticsVertical v-bind="statisticsVertical" />
    </VCol>

    <!-- 👉 Project Table -->
    <VCol cols="12" lg="12">
      <AnalyticsReportTable :status="status" :limit="limit"  />
    </VCol>
  </VRow>
</template>

<style lang="scss">
  @use "@core/scss/template/libs/apex-chart.scss";
</style>
