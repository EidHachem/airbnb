class Property < ApplicationRecord

    validates :name, presence: :true
    validates :headline, presence: :true
    validates :description, presence: :true
    validates :address_1, presence: :true
    validates :city, presence: :true
    validates :state, presence: :true
    validates :country, presence: :true

    monetize :price_cents, allow_nil: true

    has_many_attached :images
    has_many :reviews, dependent: :destroy
    has_many :wishlists, dependent: :destroy
    has_many :wishlisted_users, through: :wishlists, source: :user, dependent: :destroy
    has_many :reservations, dependent: :destroy
    has_many :reserved_users, through: :reservations, source: :user, dependent: :destroy

    def update_average_rating
        average_rating = reviews.average(:final_rating)
        update_column(:average_final_rating, average_rating)
    end

    def wishlisted_by?(user)
        return wishlisted_users.include?(user) unless user.nil?
    end

    def available_dates
        next_reservation = reservations.upcoming_reservations.first
        current_reservation = reservations.current_reservations.first

        start_date = current_reservation&.checkout_date || Date.tomorrow
        end_date = next_reservation&.checkin_date || (Date.tomorrow + 5.days)

        start_date.strftime('%e %b')..end_date.strftime('%e %b')
    end

end
