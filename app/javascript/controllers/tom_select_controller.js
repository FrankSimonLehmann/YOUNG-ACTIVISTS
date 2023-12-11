import { Controller } from "@hotwired/stimulus";
import TomSelect from "tom-select";

// Connects to data-controller="tom-select"
export default class extends Controller {

  static values = { options: Object }
  connect() {
    new TomSelect(  this.element,
        {
          plugins: {
            remove_button:{
              title:'Remove this item',
            }
          },
          persist: false,
          create: true,
          maxItems: 2,
        }
      )

  }
}
