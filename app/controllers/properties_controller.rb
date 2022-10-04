class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show edit update destroy]

  def index
    @properties = Property.all
    render json: @properties
  end

  def new
    @property = Property.new
  end

  def show
    render json: @property
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      render json: @property, status: :created
    else
      render json: @property.errors, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @property.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def property_params
    params.require(:property).permit(:operation_type, :pets, :maintenance, :user_id, :bathrooms, 
                                    :bedrooms, :property_type, :price, :photos, :about, :address, :active)
  end

  def set_property
    @property = Property.find(params[:id])
  end
end
