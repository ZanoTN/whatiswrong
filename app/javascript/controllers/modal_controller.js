import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    document.addEventListener("keydown", (event) => {
      if (event.key === "Escape") {
        this.close();
      }
    });
  }

  close() {
    // Delete the content of the turbo_frame_tag "modal" to close the modal
    const modalFrame = document.getElementById("modal");
    if (modalFrame) {
      modalFrame.innerHTML = "";
    }
  }
}
