import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {

  static targets = ["togglableElement"]

  connect() {
    console.log("hello")
  }

  remove() {
    // retirer le bouton choisir de laffichage en cliquand dessus
    this.togglableElementTarget.classList.add("d-none");
  }

}
