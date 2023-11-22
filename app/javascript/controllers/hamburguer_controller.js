import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hamburguer"
export default class extends Controller {
  static targets = ["burguer", "link"];
  expand() {
    // this.element.toggle('is-active');
    this.burguerTarget.classList.toggle('is-active');
    this.linkTarget.classList.toggle('is-active')
  }
}
