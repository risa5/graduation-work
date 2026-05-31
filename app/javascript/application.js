import "@hotwired/turbo-rails";
import "./controllers";
import "bootstrap";
import "./radar_chart.js";
import "chart.js";

import {
  Chart,
  RadarController,
  LineElement,
  PointElement,
  RadialLinearScale
} from 'chart.js'

Chart.register(
  RadarController,
  LineElement,
  PointElement,
  RadialLinearScale
)