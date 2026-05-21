import "@hotwired/turbo-rails";
import "./controllers";
import "bootstrap";
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