class HomeController < ApplicationController
  def index
    @properties = Property.order(average_final_rating: :desc)
  end
end
