import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "input", "list", "type", "topic"]

  connect() {
    console.log(this.typeTargets)
    console.log(this.topicTargets)
  }

  update() {
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`
    fetch(url, {headers: {"Accept": "text/plain"}})
      .then(response => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data
      })
  }

  type() {
    const url = `${this.formTarget.action}?query=${this.typeTarget.innerText}`
    console.log(url)
    fetch(url, {headers: {"Accept": "text/plain"}})
      .then(response => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data
      })

  }

  topic() {
    const url = `${this.formTarget.action}?query=${this.topicTarget.innerText}`
    console.log(url)
    fetch(url, {headers: {"Accept": "text/plain"}})
      .then(response => response.text())
      .then((data) => {
        this.topicTarget.outerHTML = data
      })

  }

}
