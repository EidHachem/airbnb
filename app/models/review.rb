class Review < ApplicationRecord
  belongs_to :user
  belongs_to :property, counter_cache: true

    validates :content, presence: :true
    validates :cleanliness_rating, numericality: {only_integer: true, grater_than_or_equal_to: 1, less_than_or_equal_to: 5} ,presence: :true
    validates :accuracy_rating, numericality: {only_integer: true, grater_than_or_equal_to: 1, less_than_or_equal_to: 5} ,presence: :true
    validates :checkin_rating, numericality: {only_integer: true, grater_than_or_equal_to: 1, less_than_or_equal_to: 5} ,presence: :true
    validates :communication_rating, numericality: {only_integer: true, grater_than_or_equal_to: 1, less_than_or_equal_to: 5} ,presence: :true
    validates :location_rating, numericality: {only_integer: true, grater_than_or_equal_to: 1, less_than_or_equal_to: 5} ,presence: :true
    validates :value_rating, numericality: {only_integer: true, grater_than_or_equal_to: 1, less_than_or_equal_to: 5} ,presence: :true

    after_commit :update_final_rating, on: [:create, :update]

    def update_final_rating
      average_rating = (cleanliness_rating + accuracy_rating + checkin_rating + communication_rating + location_rating + value_rating) / 6.0
      update_column(:final_rating, average_rating)
      property.update_average_rating
    end
end
