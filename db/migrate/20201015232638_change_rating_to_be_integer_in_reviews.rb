class ChangeRatingToBeIntegerInReviews < ActiveRecord::Migration[5.2]
  def change
    change_column :reviews, :rating, :integer, using: 'rating::integer'
  end
end
