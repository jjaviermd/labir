import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tooltips"
export default class extends Controller {
  // connect() {
  //   console.log("Hello, Stimulus!", this.element)
  // }
  sendReportTooltip() {
    console.log("tooltip");
  }
}
