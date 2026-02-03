import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modal"
export default class extends Controller {
  static values = { type: String };

  connect() {
    // Listener per l'escape key
    this.escapeListener = (event) => {
      if (event.key === "Escape" && this.canBeClosed()) {
        this.close();
      }
    };
    document.addEventListener("keydown", this.escapeListener);
  }

  disconnect() {
    document.removeEventListener("keydown", this.escapeListener);
  }

  close() {
    const modalFrame = document.getElementById(this.getModalIdValue());
    if (modalFrame) {
      modalFrame.innerHTML = "";
    }
  }

  confirm() {
    this.close();
  }

  canBeClosed() {
    if (this.getModalIdValue() === "confirm-modal") {
      return false;
    }

    if (this.getModalIdValue() === "modal") {
      const confirmModal = document.getElementById("confirm_modal");
      if (confirmModal && confirmModal.innerHTML.trim() !== "") {
        return false;
      }
    }

    return true;
  }

  // Restituisce l'ID del modal o "modal" di default
  getModalIdValue() {
    return this.hasTypeValue ? this.typeValue : "modal";
  }
}
