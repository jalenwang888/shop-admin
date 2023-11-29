<script setup>
  //import VueApexCharts from 'vue3-apexcharts'
  import VueApexCharts from '@core/libs/apex-chart/src'


  import {useTheme} from 'vuetify'
  import {getLineChartSimpleConfig} from '@core/libs/apex-chart/apexCharRealtimeConfig'

  const vuetifyTheme = useTheme()
  const balanceChartConfig = computed(() => getLineChartSimpleConfig(vuetifyTheme.current.value))


  const props = defineProps(['animate','series'])

  const series = ref([])
  series.value =  [
        {
          data: props.series
        }
      ]

  const animate = ref(props.animate)

  /**
  const reactiveProps = toRefs(props);
    watch(reactiveProps.series, () => {
      console.log("PROPS"+ JSON.stringify(props))
    });
**/

</script>

<template>
  <VueApexCharts type="line" ref="realtimeChart" height="400" :animate="props.animate" :options="balanceChartConfig" :series="series" />
</template>


