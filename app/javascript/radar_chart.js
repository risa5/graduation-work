import {
  Chart,
  RadarController,
  LineElement,
  PointElement,
  RadialLinearScale,
  Filler
} from 'chart.js'

Chart.register(
  RadarController,
  LineElement,
  PointElement,
  RadialLinearScale,
  Filler
)

const resultChart = document.getElementById("result_chart");

const bodyScore = Number(resultChart.dataset.bodyScore);
const mindScore = Number(resultChart.dataset.mindScore);
const emotionScore = Number(resultChart.dataset.emotionScore);

const data = {
  labels: [
    "身体の疲労",
    "脳の疲労",
    "心の疲労",
  ],
  datasets: [
    {
      data: [bodyScore, mindScore, emotionScore],
      fill: true,
      backgroundColor: 'rgba(255, 99, 132, 0.2)',
      borderColor: 'rgb(255, 99, 132)',
      pointBackgroundColor: 'rgb(255, 99, 132)',
      pointHoverBorderColor: 'rgb(255, 99, 132)'
    }
  ]
};

const config = {
  type: "radar",
  data: data,
  options: {
    elements: {
      line: {
        borderWidth: 2,
      },
      point: {
        radius: 3,
      }
    },
    scales: {
      r: {
        beginAtZero: true,
        max: 12,
        ticks: {
          stepSize: 2,
          font: {
            size: 10
          }
        },
        pointLabels: {
          font: {
            size: 12
          }
        }
      }
    },
    plugins: {
      legend: {
        display: false
      }
    }
  }
};

new Chart(resultChart, config);