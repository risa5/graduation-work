// 利用規約同意確認用jQuery

import $ from "jquery";

document.addEventListener("turbo:load", () => {
  console.log("terms_checkbox loaded");

  const checkbox = $("#terms_checkbox");
  const button   = $("#submit_btn");

  if (checkbox.length === 0 || button.length === 0) return;

  checkbox.off("change").on("change", function () {
    button.prop("disabled", !$(this).prop("checked"));
  });
});