import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static values = {
        email: String,
    }
    static targets = ["messages"]

    connect() {
        document.cookie.split("; ").forEach(cookiePart => {
            const [cookieKey, cookieValue] = cookiePart.split("=");

            console.log(cookieKey == "current_user_email")

            if (cookieKey === "current_user_email") {
                this.email = decodeURIComponent(cookieValue);
            }
        })

        console.log(this.email)

        this.messages = document.querySelector("#messages");

        this.messages.scroll({ top: this.messages.scrollHeight });
        this.messages.addEventListener("DOMNodeInserted", event => this.nodeAdded(this.email, event));

        console.log(this.messages.childElementCount)

        for (var i = 0; i < this.messages.childElementCount; i++) {
            const [add, remove] = this.email == this.messages.children[i].dataset.author ? ["current_user_message_bubble", "message_bubble"]: ["message_bubble", "current_user_message_bubble"];
            this.messages.children[i].classList.add(add);
            this.messages.children[i].classList.remove(remove);
        }
    }

    disconnect() {
        this.messages.removeEventListener("DOMNodeInserted");
    }

    nodeAdded(email, event) {
        this.messages = document.querySelector("#messages");
        this.messages.scroll({ top: messages.scrollHeight });

        const [add, remove] = email == event.target.dataset.author ? ["current_user_message_bubble", "message_bubble"]: ["message_bubble", "current_user_message_bubble"];
        event.target.classList.add(add);
        event.target.classList.remove(remove);
    }
}