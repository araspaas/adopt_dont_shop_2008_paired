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

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params)

    redirect_to("/shelters/#{review_params[:shelter_id]}")
  end

  def destroy
    Review.find(params[:id]).destroy
    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :shelter_id)
  end
end
