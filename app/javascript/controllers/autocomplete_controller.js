import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="autocomplete"
export default class extends Controller {

  autocomplete(e) {
    let prefix = e.target.value;
    let url;
    let target_id = e.target.id
    switch (target_id) {
      case "case_macro_description":
        url = "/macro_templates.json"
        break;
      case "case_micro_description":
        url = "/micro_templates.json"
        break;
      case "case_diagnosis":
        url = "/diagnosis_templates.json"
    }
    // console.log(prefix, url, target_id);
    fetch(url)
      .then((response) => response.json())
      .then((templates) => e.target.value = templates.find((template) => template.prefix === prefix).text);
  }
}
