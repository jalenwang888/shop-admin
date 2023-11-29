import { hexToRgb } from '@layouts/utils'


// 👉 Colors variables
const colorVariables = themeColors => {
  const themeSecondaryTextColor = `rgba(${hexToRgb(themeColors.colors['on-surface'])},${themeColors.variables['medium-emphasis-opacity']})`
  const themeDisabledTextColor = `rgba(${hexToRgb(themeColors.colors['on-surface'])},${themeColors.variables['disabled-opacity']})`
  const themeBorderColor = `rgba(${hexToRgb(String(themeColors.variables['border-color']))},${themeColors.variables['border-opacity']})`
  const themePrimaryTextColor = `rgba(${hexToRgb(themeColors.colors['on-surface'])},${themeColors.variables['high-emphasis-opacity']})`
  
  return { themeSecondaryTextColor, themeDisabledTextColor, themeBorderColor, themePrimaryTextColor }
}


let XAXISRANGE = 60000

export const getLineChartSimpleConfig = themeColors => {
  const { themeBorderColor, themeDisabledTextColor } = colorVariables(themeColors)
  
  return {
    chart: {
      id: 'realtimeChart',
      parentHeightOffset: 0,
      zoom: { enabled: false },
      toolbar: { show: false },
      type: 'line',
      animations: {
        enabled: true,
        easing: 'linear',
        dynamicAnimation: {
          speed: 1000
        }
      },
    },

    colors: ['#ff9f43'],
    stroke: { curve: 'smooth' },
    dataLabels: { enabled: false },
    markers: {
      size: 0,
      strokeWidth: 7,
      strokeOpacity: 1,
      colors: ['#ff9f43'],
      strokeColors: ['#fff'],
    },
    grid: {
      padding: { top: -10 },
      borderColor: themeBorderColor,
      xaxis: {
        lines: { show: true },
      },
    },
    tooltip: {
      custom(data) {
        return `<div class='bar-chart pa-2'>
          <span>${data.series[data.seriesIndex][data.dataPointIndex]}%</span>
        </div>`
      },
    },
    yaxis: {
      labels: {
        style: { colors: themeDisabledTextColor, fontSize: '0.8125rem' },
      },
    },
    xaxis: {
      //type: 'numeric',
      type: 'datetime',
      tickInterval: 24 * 3600 * 1000,
      startOnTick: true,
      endOnTick: true,
      range: XAXISRANGE,

      animate: false,
      
      bounds: 'ticks',

      axisBorder: { show: false },
      axisTicks: { color: themeBorderColor },
      crosshairs: {
        stroke: { color: themeBorderColor },
      },
      labels: {
        style: { colors: themeDisabledTextColor, fontSize: '0.8125rem' },
      },
      
    },
  }
}
