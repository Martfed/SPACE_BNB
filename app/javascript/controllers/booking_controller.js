import { Controller } from "stimulus"

export default class extends Controller {
  static targets = []

  connect() {

    let message = this.element
    if (message.innerHTML.includes("Your booking was confirmed!")) {
      message.classList.toggle("visible")
      message.style.backgroundColor = "green";
    } else if (message.innerHTML.includes("A spaceship is already booked for that period!")) {
      message.classList.toggle("visible")
      message.style.backgroundColor = "orange";
    } else if (message.innerHTML.includes("Please enter a valid date range")){
      message.classList.toggle("visible")
      message.style.backgroundColor = "red";
    } else {
      message.style.visibility = "hidden";
    }
  }
}

