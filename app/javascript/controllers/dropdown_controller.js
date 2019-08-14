import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["results", "allbookings"]

  initialize() {

    (this.allbookingsTarget).addEventListener("click", (event) => {
      (this.resultsTarget).insertAdjacentHTML("beforeend", "<p>Hello</p>");
     });

  }
}

