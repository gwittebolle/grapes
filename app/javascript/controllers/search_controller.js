import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {

  static targets = ["search", "card"]

  connect() {
  }

  search() {
    const query = this.searchTarget.value.toLowerCase();
    // Afficher ou masquer les cartes en fonction du résultat de la recherche
  this.cardTargets.forEach((card) => {
    card.innerText.toLowerCase().includes(query) ? card.classList.remove("d-none") : card.classList.add("d-none");
  });
  }
}
