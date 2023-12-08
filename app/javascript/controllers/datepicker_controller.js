import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
// Connects to data-controller="datepicker"
export default class extends Controller {
  static targets = ["startTime", "endTime"]
  connect() {
    console.log("hello")
    flatpickr(this.startTimeTarget,
      {
        enableTime: true,
        altInput: true,
        altFormat: "F j, Y, H:i",
        dateFormat: "Y-m-d H:i",
      }
      )
      flatpickr(this.endTimeTarget,
        {
          enableTime: true,
          altInput: true,
          altFormat: "F j, Y, H:i",
          dateFormat: "Y-m-d H:i",
        }
        )
  }
}
