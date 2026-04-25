
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]
  static values = {
    url: String,
    field: String
  }

  async search() {
    const keyword = this.inputTarget.value.trim()

    if (keyword === "") {
      this.resultsTarget.innerHTML = ""
      return
    }

    const params = new URLSearchParams({
      keyword: keyword,
      field: this.fieldValue
    })

    const response = await fetch(`${this.urlValue}?${params}`, {
      headers: { Accept: "text/html" }
    })

    const html = await response.text()
    this.resultsTarget.innerHTML = html
  }

  select(event) {
    const value = event.currentTarget.dataset.autocompleteValue
    this.inputTarget.value = value
    this.resultsTarget.innerHTML = ""
  }
}