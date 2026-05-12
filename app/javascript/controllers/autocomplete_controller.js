import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]
  static values = {
    url: String,
    field: String
  }

  async search() {
    const keyword = this.inputTarget.value.trim()

    // 空欄であればここで終了
    if (keyword === "") {
      this.resultsTarget.innerHTML = ""
      return
    }

    // クエリパラメータ作成
    const params = new URLSearchParams({
      keyword: keyword,
      field: this.fieldValue
    })

    // Railsからのレスポンスを取得
    const response = await fetch(`${this.urlValue}?${params}`, {
      headers: { Accept: "text/html" }
    })

    // レスポンスをHTMLへ変換・HTML要素（resultsTarget）へ渡す
    const html = await response.text()
    this.resultsTarget.innerHTML = html
  }

  // 候補をクリックで検索欄へ文字を入れる・候補を空欄にする
  select(event) {
    const value = event.currentTarget.dataset.autocompleteValue
    this.inputTarget.value = value
    this.resultsTarget.innerHTML = ""
  }
}