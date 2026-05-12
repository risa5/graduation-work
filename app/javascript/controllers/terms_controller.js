import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  // "checkbox", "submit", "googleWrapper"を操作対象に指定
  static targets = ["checkbox", "submit", "googleWrapper"];

  // 指定したDOM要素が画面表示された時点でtoggleを実行
  connect() {
    this.toggle();
  }

  toggle() {
    // チェック状態をcheckedプロパティで取得
    const agreed = this.checkboxTarget.checked;

    // Submitボタンの活性・非活性切り替え
    this.submitTarget.disabled = !agreed;
    // Google登録ボタンの活性・非活性切り替え
    this.googleWrapperTarget.classList.toggle("google-disabled", !agreed);
  }
}