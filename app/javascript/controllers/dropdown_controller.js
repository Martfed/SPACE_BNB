import { Controller } from "stimulus"

export default class extends Controller {

  static targets = [
                    "results_active_bookings", "activebookings",
                    "results_rejected_bookings", "rejectedbookings",
                    "results_accepted_bookings", "acceptedbookings",
                    "results_all_bookings", "allbookings",
                    "results_pending_bookings", "pendingbookings",
                    "results_done_bookings", "donebookings",
                    ]

  initialize() {

    (this.allbookingsTarget).addEventListener("click", (event) => {
      (this.results_pending_bookingsTarget).classList.add("pendingbookings");
      (this.results_accepted_bookingsTarget).classList.add("acceptedbookings");
      (this.results_active_bookingsTarget).classList.add("activebookings");
      (this.results_rejected_bookingsTarget).classList.add("rejectedbookings");
      (this.results_done_bookingsTarget).classList.add("donebookings");
      (this.results_all_bookingsTarget).classList.remove("allbookings");
     });

    (this.pendingbookingsTarget).addEventListener("click", (event) => {
      (this.results_all_bookingsTarget).classList.add("allbookings");
      (this.results_accepted_bookingsTarget).classList.add("acceptedbookings");
      (this.results_active_bookingsTarget).classList.add("activebookings");
      (this.results_rejected_bookingsTarget).classList.add("rejectedbookings");
      (this.results_done_bookingsTarget).classList.add("donebookings");
      (this.results_pending_bookingsTarget).classList.remove("pendingbookings");
     });

    (this.acceptedbookingsTarget).addEventListener("click", (event) => {
      (this.results_all_bookingsTarget).classList.add("allbookings");
      (this.results_pending_bookingsTarget).classList.add("pendingbookings");
      (this.results_active_bookingsTarget).classList.add("activebookings");
      (this.results_rejected_bookingsTarget).classList.add("rejectedbookings");
      (this.results_done_bookingsTarget).classList.add("donebookings");
      (this.results_accepted_bookingsTarget).classList.remove("acceptedbookings");
     });

    (this.rejectedbookingsTarget).addEventListener("click", (event) => {
      (this.results_all_bookingsTarget).classList.add("allbookings");
      (this.results_pending_bookingsTarget).classList.add("pendingbookings");
      (this.results_accepted_bookingsTarget).classList.add("acceptedbookings");
      (this.results_active_bookingsTarget).classList.add("activebookings");
      (this.results_done_bookingsTarget).classList.add("donebookings");
      (this.results_rejected_bookingsTarget).classList.remove("rejectedbookings");
     });

    (this.activebookingsTarget).addEventListener("click", (event) => {
      (this.results_all_bookingsTarget).classList.add("allbookings");
      (this.results_pending_bookingsTarget).classList.add("pendingbookings");
      (this.results_accepted_bookingsTarget).classList.add("acceptedbookings");
      (this.results_rejected_bookingsTarget).classList.add("rejectedbookings");
      (this.results_done_bookingsTarget).classList.add("donebookings");
      (this.results_active_bookingsTarget).classList.remove("activebookings");
     });

    (this.donebookingsTarget).addEventListener("click", (event) => {
      (this.results_all_bookingsTarget).classList.add("allbookings");
      (this.results_pending_bookingsTarget).classList.add("pendingbookings");
      (this.results_accepted_bookingsTarget).classList.add("acceptedbookings");
      (this.results_rejected_bookingsTarget).classList.add("rejectedbookings");
      (this.results_active_bookingsTarget).classList.add("activebookings");
      (this.results_done_bookingsTarget).classList.remove("donebookings");
     });
  }
}

