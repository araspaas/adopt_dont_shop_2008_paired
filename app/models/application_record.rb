class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def average_review_rating
    avg = reviews.average(:rating)
    if avg.nil?
      avg = 0
    end
    avg.to_f
  end
end
