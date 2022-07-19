import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static values = {
        email: String,
    }
    static targets = ["message"]

    initialize() {
        console.log(document.cookie);

        document.cookie.split("; ").forEach(cookiePart => {
            const [cookieKey, cookieValue] = cookiePart.split("=");

            if (cookieKey === "current_user_email" && this.emailValue == decodeURIComponent(cookieValue)) {
                this.messageTarget.classList.add("current_user_message_bubble")
            } else if (cookieKey === "current_user_email" && this.emailValue != decodeURIComponent(cookieValue)) {
                this.messageTarget.classList.add("message_bubble")
            }
        })
    }
}