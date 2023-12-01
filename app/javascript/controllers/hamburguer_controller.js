import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hamburguer"
export default class extends Controller {
  static targets = ["burguer", "link"];
  expand() {
    this.burguerTarget.classList.toggle('is-active');
    this.linkTarget.classList.toggle('is-active')
  }

  toggle(event) {
    const selected = document.querySelector(".is-active")
    selected.classList.toggle("is-active")
    event.target.parentNode.classList.toggle("is-active")
  }
}
