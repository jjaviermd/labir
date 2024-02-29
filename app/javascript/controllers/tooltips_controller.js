import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tooltips"
export default class extends Controller {
  static targets = ["tooltipText"]
  // connect() {
  //   console.log("Hello, Stimulus!", this.element)
  // }
  sendReportTooltip() {
    const isButtonDisabled = !!this.tooltipTextTarget.previousElementSibling.getAttribute("disabled")
    if (isButtonDisabled) {
      this.tooltipTextTarget.classList.toggle("is-hidden")
      // window.setTimeout(() => { this.tooltipTextTarget.classList.toggle("is-hidden") }, 1500)
    }
  }
}
