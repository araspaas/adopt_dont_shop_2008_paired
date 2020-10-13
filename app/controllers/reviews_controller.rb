class ReviewsController < ApplicationController

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    user = User.find_by(name: params[:name])
    user.reviews.create!(review_params)
    redirect_to "/shelters/#{@shelter.id}"
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :shelter_id)
  end
end
