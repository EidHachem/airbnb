import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  updateWishlistStatus() {
    if (this.element.dataset.status === 'true') {
        this.element.classList.remove('fill-primary')
        this.element.classList.add("fill-none")
        this.element.dataset.status = 'false'
    } else {
        this.element.classList.remove('fill-none')
        this.element.classList.add("fill-primary")
        this.element.dataset.status = 'true'
    }
  }
}
