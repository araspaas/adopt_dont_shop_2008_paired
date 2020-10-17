class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    if user
      save_app
    else
      flash.now[:errors] = "User Must Exist"
      render :new
    end
  end

  private

  def user
    @user ||= User.find_by(name: params[:user_name])
  end

  def save_app
    @application = user.applications.new
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash.now[:errors] = "#{@application.errors.full_messages.to_sentence}"
      render :new
    end
  end
end
