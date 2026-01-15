import "@hotwired/turbo-rails";
import "./controllers";
import "@popperjs/core";
import "bootstrap";
import $ from "jquery"
window.$ = $
window.jQuery = $
import "./terms_checkbox"

import Dropdown from "bootstrap/js/dist/dropdown";
import Collapse from "bootstrap/js/dist/collapse";

window.bs = { Dropdown, Collapse };

const initBootstrapOnce = () => {

  if (window.__bsHandlersBound) return;
  window.__bsHandlersBound = true;

  const prepareCollapseTargets = () => {
    document.querySelectorAll(".collapse").forEach((el) => {
      Collapse.getOrCreateInstance(el, { toggle: false });
    });
  };

  document.addEventListener("click", (ev) => {
    const toggle = ev.target.closest('[data-bs-toggle="dropdown"]');
    if (!toggle) return;
    ev.preventDefault();
    Dropdown.getOrCreateInstance(toggle).toggle();
  });

  document.addEventListener("click", (ev) => {
    const btn = ev.target.closest('[data-bs-toggle="collapse"][data-bs-target]');
    if (!btn) return;
    ev.preventDefault();
    const sel = btn.getAttribute("data-bs-target");
    const target = sel ? document.querySelector(sel) : null;
    if (!target) return;
    Collapse.getOrCreateInstance(target).toggle();
  });

  prepareCollapseTargets();

  document.addEventListener("turbo:load", prepareCollapseTargets);

  console.log("[bootstrap] global handlers bound");
};

document.addEventListener("turbo:load", initBootstrapOnce);
document.addEventListener("DOMContentLoaded", initBootstrapOnce);

document.addEventListener("DOMContentLoaded", () => {
  const termsCheckbox = document.getElementById("terms_checkbox");
  const submitBtn = document.getElementById("submit_btn");
  const googleWrapper = document.getElementById("google_login_wrapper");

  if (!termsCheckbox) return;

  const toggleButtons = () => {
    if (termsCheckbox.checked) {
      submitBtn.disabled = false;
      googleWrapper.classList.remove("google-disabled");
    } else {
      submitBtn.disabled = true;
      googleWrapper.classList.add("google-disabled");
    }
  };

  toggleButtons();

  termsCheckbox.addEventListener("change", toggleButtons);
});