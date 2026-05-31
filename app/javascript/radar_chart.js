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
    }
  ]
};

const config = {
  type: "radar",
  data: data,
  options: {}
};

new Chart(resultChart, config);