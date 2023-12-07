import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "input", "list", "topic", "type"]
  static values = {typeColor: String, topicColor: String}

  connect() {
    console.log(`${this.typeTargets}`)
    console.log(this.topicTargets)
    this.paramsTopic = []
    this.paramsType = []
  }

  update() {

    const url = new URL(window.location.href)
    url.searchParams.set("query", this.inputTarget.value)
    history.pushState(null, null, url)
    // const url = `${this.formTarget.action}?query=${this.inputTarget.value}`
    fetch(url, {headers: {"Accept": "text/plain"}})
      .then(response => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data
      })
  }

  type(event) {
    // check if the topic is already in the array
    if (this.paramsType.includes(event.currentTarget.innerText)) {
      // remove from array if clicked again
      this.paramsType.splice(this.paramsType.indexOf(event.currentTarget.innerText), 1)
    }
    else {
    // add to array if clicked
    this.paramsType.push(event.currentTarget.innerText)
    }

    // build the url
    const url = new URL(window.location.href)
    url.searchParams.set("type", this.paramsType.join("+"))
    // display the url
    history.pushState(null, null, url)

    // send a AJAX request to the server
    fetch(url, {headers: {"Accept": "text/plain"}})
    .then(response => response.text())
    .then((data) => {
      // change the look of the button
      event.srcElement.classList.toggle("label_active_pink")

      // change the list to only display the selected type
      this.listTarget.outerHTML = data
    })
}

  topic(event) {
    console.log(this.typeColorValue)
    console.log(this.topicColorValue)
    // check if the topic is already in the array
    if (this.paramsTopic.includes(event.currentTarget.innerText)) {
       // remove from array if clicked again
      this.paramsTopic.splice(this.paramsTopic.indexOf(event.currentTarget.innerText), 1)
    }
    else {
      // add to array if clicked
    this.paramsTopic.push(event.currentTarget.innerText)
    }

    // build the url
    const url = new URL(window.location.href)
    url.searchParams.set("topic", this.paramsTopic.join("+"))
    // display the url
    history.pushState(null, null, url)

    // send a AJAX request to the server
    fetch(url, {headers: {"Accept": "text/plain"}})
    .then(response => response.text())
    .then((data) => {
      this.listTarget.outerHTML = data
        // change the look of the button
        event.srcElement.classList.toggle("btn-primary")
    })
  }
}
