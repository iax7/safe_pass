import {Controller} from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["clearButton"];

  toggleClearButton = (event) => {
    if (event.target.value)
      this.clearButtonTarget.classList.remove("d-none");
    else
      this.clearButtonTarget.classList.add("d-none");
  }
}
