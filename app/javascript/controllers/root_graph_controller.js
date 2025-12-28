import { Controller } from "@hotwired/stimulus"

import "https://cdn.jsdelivr.net/npm/apexcharts"

// Connects to data-controller="root-graph"
export default class extends Controller {
  static targets = [ "graph" ]
  static values = {
    data: Object,
    theme: String
  }

  connect() {
    const data = this.dataValue;
    const theme = this.themeValue;

    if (!this.graphTarget) return

    window.ApexCharts && new ApexCharts(this.graphTarget, {
      chart: {
        type: "area",
        fontFamily: 'inherit',
        height: 280,
        parentHeightOffset: 0,
        toolbar: {
          show: false,
        },
        animations: {
          enabled: false
        },
        stacked: true,
      },
      plotOptions: {
        bar: {
          columnWidth: '50%',
        }
      },
      dataLabels: {
        enabled: false
      },
      series: [{
        name: "Errors",
        data: data.errors
      }, {
        name: "Warnings",
        data: data.warnings
      }, {
        name: "Info",
        data: data.info
      }],
      tooltip: {
        theme: theme
      },
      grid: {
        padding: {
          top: -20,
          right: 0,
          left: -4,
          bottom: -4
        },
        strokeDashArray: 4,
        borderColor: theme === "dark" ? "#444" : "#e0e0e0"
      },
      xaxis: {
        labels: {
          padding: 0,
          style: {
            colors: theme === "dark" ? "#d0d0d0" : "#333"
          }
        },
        tooltip: {
          enabled: false
        },
        type: 'datetime',
      },
      yaxis: {
        labels: {
          padding: 4,
          style: {
            colors: theme === "dark" ? "#d0d0d0" : "#333"
          }
        },
      },
      labels: data.labels,
      colors: [
        'rgb(195,60,60)',
        'rgb(245,159,0)',
        'rgb(66,153,225)'
      ],
      fill: {
        type: 'solid',
        opacity: 0.5
      },
      legend: {
        labels: {
          colors: theme === "dark" ? "#d0d0d0" : "#333"
        },
        show: true,
        position: 'bottom',
        offsetY: 12,
        markers: {
          width: 10,
          height: 10,
          radius: 100,
        },
        itemMargin: {
          horizontal: 10,
          vertical: 10
        },
      },
    }).render();
  };
}
