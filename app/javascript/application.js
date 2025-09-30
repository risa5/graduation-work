import "@hotwired/turbo-rails";
import "./controllers";

// 既に導入済みのはず
import Dropdown from "bootstrap/js/dist/dropdown";
import Collapse from "bootstrap/js/dist/collapse";

// デバッグ用
window.bs = { Dropdown, Collapse };

// ▼ ここから追記／置き換え
const initBootstrapOnce = () => {
  // Turbo で複数回呼ばれても二重にバインドしない
  if (window.__bsHandlersBound) return;
  window.__bsHandlersBound = true;

  // 1) collapse 対象（開閉される側 .collapse）を事前にインスタンス化
  const prepareCollapseTargets = () => {
    document.querySelectorAll(".collapse").forEach((el) => {
      Collapse.getOrCreateInstance(el, { toggle: false });
    });
  };

  // 2) ドロップダウン：クリックで確実に toggle（イベント委譲）
  document.addEventListener("click", (ev) => {
    const toggle = ev.target.closest('[data-bs-toggle="dropdown"]');
    if (!toggle) return;
    ev.preventDefault(); // href="#" のスクロール抑止
    Dropdown.getOrCreateInstance(toggle).toggle();
  });

  // 3) ハンバーガー：ボタン→対象(.collapse)を確実に toggle（イベント委譲）
  document.addEventListener("click", (ev) => {
    const btn = ev.target.closest('[data-bs-toggle="collapse"][data-bs-target]');
    if (!btn) return;
    ev.preventDefault();
    const sel = btn.getAttribute("data-bs-target");
    const target = sel ? document.querySelector(sel) : null;
    if (!target) return;
    Collapse.getOrCreateInstance(target).toggle();
  });

  // 最初のロード時点で .collapse を準備
  prepareCollapseTargets();

  // Turbo でDOMが差し替わるたびに .collapse を拾い直す
  document.addEventListener("turbo:load", prepareCollapseTargets);

  console.log("[bootstrap] global handlers bound");
};

// Turbo/通常ロードどちらでも一度だけバインド
document.addEventListener("turbo:load", initBootstrapOnce);
document.addEventListener("DOMContentLoaded", initBootstrapOnce);
