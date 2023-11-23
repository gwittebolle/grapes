import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = ["content"];

  connect() {
    this.loadNotifications();
  }

  loadNotifications() {
    // Load notifications on page load or other initializations
    this.fetchNotifications();
  }

  fetchNotifications() {
    fetch("/notifications")
      .then(response => response.text())
      .then(html => {
        this.contentTarget.innerHTML = html;
      })
      .catch(error => console.error("Error fetching notifications:", error));
  }

  // Add this method to handle button click
  refreshNotifications() {
    this.fetchNotifications();
  }
}
