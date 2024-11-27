import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ['input', 'form'];
  connect() {
    this.timeout = null;
    console.log('Search controller connected!');
  }
  search() {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      this.sendSearchTerm();
    }, 300);
  }

  sendSearchTerm() {
    const term = this.inputTarget.value.trim();
    if (term.length > 0 || term === '') {
      this.formTarget.requestSubmit();
    }
 
  }
}
