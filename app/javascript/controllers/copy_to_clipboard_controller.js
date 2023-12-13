import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="copy-to-clipboard"
export default class extends Controller {
  static targets = ["location"]
  static values = { location: String }

  connect() {
    console.log("Hello, Stimulus!", this.element)
  }

  copy() {
    // get the text from the element
    const location = this.locationTarget.innerText
    // copy the text to the clipboard
    navigator.clipboard.writeText(location)

    // give a pop-up that the text has been copied using turbo method!
    this.element.insertAdjacentHTML("afterbegin", "<div class='alert alert-success'>Copied!</div>")

    // Remove the pop-up after 3 seconds
    setTimeout(() => {
      const alertElement = this.element.querySelector(".alert")
      if (alertElement) {
        alertElement.remove()
      }
    }, 2000)
  }
}
