import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.element.scroll({ top: this.element.scrollHeight })
        this.messagesTarget.addEventListener("DOMNodeInserted", this.scrollToBottom)
    }

    scrollToBottom() {
        const messages = document.querySelector("#messages");
        messages.scroll({ top: messages.scrollHeight, behavior: "smooth" })
    }
}