import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="app-form"
export default class extends Controller {
  static targets = [ "copyButton" , "apiKey" ]

  connect() {
    this.copyButtonTarget.addEventListener("click", this.copyFormLink.bind(this))
  }

  copyFormLink(event) {
    event.preventDefault()
    const apiKey = this.apiKeyTarget.value
    navigator.clipboard.writeText(apiKey).catch(err => {
      console.log("Failed to copy text: ", err)
    })
  }


}
