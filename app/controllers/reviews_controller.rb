class ReviewsController < ApplicationController
  before_action :shelter, only: [:new, :create, :update]

  def new
  end

  def create
    @user = User.find_by(name: params[:name])
    if @user
      save_review(@user)
    else
      flash.now[:errors] = "User Must Exist"
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    if @review.save
      redirect_to("/shelters/#{review_params[:shelter_id]}")
    else
      flash.now[:errors] = "#{@review.errors.full_messages.to_sentence}"
      render :edit
    end
  end

  def destroy
    Review.find(params[:id]).destroy
    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  private
  def review_params
    params.permit(:title, :rating, :content, :shelter_id, :user_id)
  end

  def shelter
    @shelter ||= Shelter.find(params[:shelter_id])
  end

  def save_review(user)
    @review = user.reviews.new(review_params)
    if @review.save
      redirect_to "/shelters/#{params[:shelter_id]}"
    else
      flash.now[:errors] = "#{@review.errors.full_messages.to_sentence}"
      render :new
    end
  end
end
