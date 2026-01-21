import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="notification-service"
export default class extends Controller {
  static targets = ["serviceFormInput"];

  connect() {
    this.toggleServiceForm();

    this.serviceFormInputTarget.addEventListener("change", () => {
      this.toggleServiceForm();
    });
  }

  toggleServiceForm() {
    const selectedService = this.serviceFormInputTarget.value;

    // Hide all service specific fields by class *-fields
    const serviceFields = this.element.querySelectorAll("[class$='-fields']");
    serviceFields.forEach((field) => {
      field.style.display = "none";
    });

    // Show the selected service fields
    const selectedFields = this.element.querySelectorAll(`.${selectedService}-fields`);
    selectedFields.forEach((field) => {
      field.style.display = "block";
    });
  }
}
