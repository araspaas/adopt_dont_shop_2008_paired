class User < ApplicationRecord
  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip
  has_many :reviews
  has_many :shelters, through: :reviews

  def average_review_rating
    reviews.average(:rating)
  end
end
