class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @search_results = Pet.search(params[:search]) if params[:search]
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

  def update
    @application = Application.find(params[:id])
    if params[:pet]
      pet = Pet.find(params[:pet])
      @application.pets << pet
      redirect_to "/applications/#{@application.id}"
      return
    end
    if params[:description].nil? || params[:description] == ""
      flash.now[:errors] = "Must enter a Description"
      render :show
    else
      @application.update(status: 1, description: params[:description])
      redirect_to "/applications/#{@application.id}"
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
    end
  end
end
