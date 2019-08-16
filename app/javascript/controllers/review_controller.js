import { Controller } from "stimulus"

export default class extends Controller {
  static targets = []

  connect() {

    let message = this.element
    if (message.innerHTML.includes("A review for this booking was already found. You can only do one review per booking.")) {
      message.classList.toggle("visible")
      message.style.backgroundColor = "red";
    } else {
      message.style.visibility = "hidden";
    }
  }
}

