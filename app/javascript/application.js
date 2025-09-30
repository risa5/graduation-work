import "@hotwired/turbo-rails";
import "./controllers";

// Bootstrap の必要コンポーネントだけ ESM で読み込み
import Dropdown from "bootstrap/js/dist/dropdown";
import Collapse from "bootstrap/js/dist/collapse";

// デバッグ用にグローバルへ
window.bs = { Dropdown, Collapse };

const initBootstrap = () => {
  // ▼ Dropdown: トグル要素を初期化
  document.querySelectorAll('[data-bs-toggle="dropdown"]').forEach((el) => {
    if (Dropdown.getOrCreateInstance) {
      Dropdown.getOrCreateInstance(el);
    } else {
      Dropdown.getInstance(el) || new Dropdown(el);
    }
  });

  // ▼ Collapse: 「開閉される側（.collapse）」を初期化 ※ここがポイント
  document.querySelectorAll(".collapse").forEach((el) => {
    if (Collapse.getOrCreateInstance) {
      Collapse.getOrCreateInstance(el, { toggle: false });
    } else {
      Collapse.getInstance(el) || new Collapse(el, { toggle: false });
    }
  });

  console.log("[bootstrap] initialized");
};

// Turbo遷移＆通常ロードの両方で初期化
document.addEventListener("turbo:load", initBootstrap);
document.addEventListener("DOMContentLoaded", initBootstrap);
