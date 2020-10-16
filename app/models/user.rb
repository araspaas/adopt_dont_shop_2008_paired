class User < ApplicationRecord
  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip
  has_many :reviews
  has_many :shelters, through: :reviews

  def average_review_rating
    avg = reviews.average(:rating)
    if avg.nil?
      avg = 0
    end
    avg
  end

  def best_review
    reviews.order(rating: :desc).limit(1).first
  end

  def worst_review
    reviews.order(:rating).limit(1).first
  end
end
