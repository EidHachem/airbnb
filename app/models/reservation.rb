class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates :checkin_date, presence: true
  validates :checkout_date, presence: true

  scope :upcoming_reservations, -> do
    where('checkin_date >=?', Date.today).order(checkin_date: :asc)
  end

  scope :current_reservations, -> do
    where("checkout_date > ?", Date.today).where("checkin_date < ?", Date.today).order(:checkout_date)
  end
end
