import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {

  static targets = ["search", "card"]

  connect() {
    console.log(this.element)
    console.log(this.searchTarget)
    console.log(this.cardTargets)
  }

  search() {
    const query = this.searchTarget.value.toLowerCase();
    console.log(query)

  // Afficher ou masquer les cartes en fonction du résultat de la recherche
  this.cardTargets.forEach((card) => {
    console.log(card)
    console.log(card.innerText.toLowerCase().includes(query))
    card.innerText.toLowerCase().includes(query) ? card.classList.remove("d-none") : card.classList.add("d-none");
  });
  }
}
