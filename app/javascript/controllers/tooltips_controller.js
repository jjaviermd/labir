import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tooltips"
export default class extends Controller {
  static targets = ["tooltipText"]
  connect() {
    const isButtonDisabled = !!this.tooltipTextTarget.previousElementSibling.getAttribute("disabled")
    if (isButtonDisabled) {
      this.tooltipTextTarget.previousElementSibling.classList.toggle("is-info")
      this.tooltipTextTarget.previousElementSibling.classList.toggle("is-danger")
    }
  }
  sendReportTooltip() {
    const isButtonDisabled = !!this.tooltipTextTarget.previousElementSibling.getAttribute("disabled")
    if (isButtonDisabled) {
      this.tooltipTextTarget.classList.toggle("is-hidden")
      // window.setTimeout(() => { this.tooltipTextTarget.classList.toggle("is-hidden") }, 1500)
    }
  }
}
