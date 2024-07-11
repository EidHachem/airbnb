import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  async updateWishlistStatus() {
    const isUserLoggedIn = this.element.dataset.userLoggedIn
    if (isUserLoggedIn === 'false') {
      document.querySelector('.js-login').click()
      return
    }
    const property_id = this.element.dataset.propertyId
    const user_id = this.element.dataset.userId
    const wishlistId = this.element.dataset.wishlistId
    if (this.element.dataset.status === 'true') {
      this.element.classList.remove('fill-primary')
      this.element.classList.add('fill-none')
      this.element.dataset.status = 'false'
      await this.removePropertyFromWishlist(wishlistId)
    } else {
      this.element.classList.remove('fill-none')
      this.element.classList.add('fill-primary')
      this.element.dataset.status = 'true'
      await this.addPropertyToWishlist(property_id, user_id)
    }
  }

  async addPropertyToWishlist(propertyId, userId) {
    const params = {
      property_id: propertyId,
      user_id: userId,
    }
    const res = await fetch('/api/wishlists', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: JSON.stringify(params),
    })
      .then((response) => response.json())
      .then((data) => {
        if (data.status === 'error') {
          alert(data.message)
        } else {
          const wishlistId = data.id
          this.element.dataset.wishlistId = wishlistId
        }
      })
  }

  async removePropertyFromWishlist(wishlistId) {
    const res = await fetch(`/api/wishlists/${wishlistId}`, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    })
      .then((response) => response.json())
      .then((data) => {
        if (data.status === 'error') {
          alert(data.message)
        } else {
          this.element.dataset.wishlistId = ''
        }
      })
  }
}
