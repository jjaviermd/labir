import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autocomplete"
export default class extends Controller {
  selectHandler(e) {
    let id = e.target.value;
    fetch(`/templates/${id}`)
      .then((response) => response.json())
      .then((data) =>
        console.log(data));
  }
}
