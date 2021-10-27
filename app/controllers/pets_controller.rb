class PetsController < ApplicationController
  before_action :find_pet_id, only: [:show, :edit, :destroy, :update]

  def index
    @pets = Pet.all
  end

  def new
    @pet = Pet.new
  end

  def show
  end

  def create
    @pet = Pet.new(set_params)
    if @pet.save
      redirect_to pet_path(@pet)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @pet.update(set_params)
      redirect_to pet_path(@pet)
    else
      render "edit"
    end
  end

  def destroy
    @pet.destroy 
    redirect_to root_path
  end

  private

  def set_params
    params.require(:pet).permit(:name, :address, :species, :found_on)
  end

  def find_pet_id
    @pet = Pet.find(params[:id])
  end
end
