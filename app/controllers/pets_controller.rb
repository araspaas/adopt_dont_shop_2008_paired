class PetsController < ApplicationController

  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    @shelter = Shelter.find(params[:id])
    @pet = @shelter.pets.new(pet_params)
    @pet.save
    redirect_to "/shelters/#{@shelter.id}/pets"
  end

  private
  def pet_params
    params.permit(:image, :name, :description, :age, :sex, :status)
  end
end
