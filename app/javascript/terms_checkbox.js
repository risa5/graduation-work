import $ from "jquery";

document.addEventListener("turbo:load", () => {
  const $checkbox = $("#terms_checkbox");
  const $submitBtn = $("#submit_btn");
  const $googleWrapper = $("#google_login_wrapper");

  if ($checkbox.length === 0) return;

  const sync = () => {
    const agreed = $checkbox.prop("checked");

    // 通常登録ボタン
    if ($submitBtn.length) {
      $submitBtn.prop("disabled", !agreed);
    }

    // Googleログイン（ラッパーを無効化/有効化）
    if ($googleWrapper.length) {
      $googleWrapper.toggleClass("google-disabled", !agreed);
    }
  };

  // 初期状態反映
  sync();

  // 変更時
  $checkbox.off("change.terms").on("change.terms", sync);
});
