import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modal-form"
export default class extends Controller {
  static targets = ["form"];

  connect() {
    document.addEventListener("turbo:frame-missing", (event) => {
      if (event.target.id === "modal") {
        const response = event.detail.response;
        event.preventDefault();

        if (response.ok && response.status < 400) {
          event.detail.visit(response.url, { action: "replace" });
        } else {
          event.target.innerHTML = `
						<div class="bg-danger-100 p-4 rounded-md">
							<p class="mb-0">
								Ops! Something went wrong while loading the form.
							</p>
						</div>`;
        }
      }
    });
  }
}
