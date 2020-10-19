class AdminController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:app_id])
    app_pet = @application.application_pets.find(params[:pet_id])
    app_pet.update(status: params[:status].to_i)

    redirect_to "/admin/applications/#{params[:app_id]}"
  end
end
