import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "input", "list", "topic", "type"]
  static values = { type: String, topic: String }

  connect() {
    this.paramsTopic = []
    this.paramsType = []
  }

  update() {

    const url = new URL(window.location.href)
    url.searchParams.set("query", this.inputTarget.value)
    history.pushState(null, null, url)

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

      // change the list to only display the selected type

      this.listTarget.outerHTML = data
      // change the look of the button
      console.log(`color_${event.srcElement.innerText}`)
      console.log(event.srcElement.classList)
      event.srcElement.classList.toggle(`color_${event.srcElement.innerText}`)

    })
}

  topic(event) {
    console.log(event.currentTarget.innerText)

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
        console.log(`color_${event.srcElement.innerText}`)
        console.log(event.srcElement)
        event.srcElement.classList.toggle(`color_${event.srcElement.innerText}`)
    })
  }
}
