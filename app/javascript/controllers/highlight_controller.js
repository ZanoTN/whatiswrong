import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  async connect() {
    // 1️⃣ Carica CSS
    this.loadCSS("https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/a11y-light.min.css")

    // 2️⃣ Carica JS in sequenza
    await this.loadScript("https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js")
    await this.loadScript("https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/javascript.min.js")
    await this.loadScript("https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/ruby.min.js")
    await this.loadScript("https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/cpp.min.js")
    await this.loadScript("https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/bash.min.js")

    // 3️⃣ Evidenzia i blocchi solo quando hljs è pronto
    this.element.querySelectorAll('pre code').forEach(block => {
      hljs.highlightElement(block)
    })
  }

  loadCSS(url) {
    const link = document.createElement("link")
    link.rel = "stylesheet"
    link.href = url
    document.head.appendChild(link)
  }

  loadScript(url) {
    return new Promise((resolve, reject) => {
      const script = document.createElement("script")
      script.src = url
      script.onload = resolve
      script.onerror = reject
      document.body.appendChild(script)
    })
  }
}
