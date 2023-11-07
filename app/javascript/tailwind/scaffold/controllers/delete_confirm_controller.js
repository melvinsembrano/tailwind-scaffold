import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!", this.element);
  }

  delete(event) {
    const message = event.currentTarget.dataset.confirm;
    const confirmed = window.confirm(message);
    if (!confirmed) {
      event.preventDefault();
    }
  }
}
