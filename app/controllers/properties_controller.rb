class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show edit update destroy]
  before_action :require_login!, except: %i[index show]

  def index
    @properties = Property.all
    render json: @properties
  end

  def my_properties
    @properties = current_user.properties
    render json: @properties
  end

  def new
    @property = Property.new
  end

  def show
    render json: @property
  end

  def create
    @property = current_user.properties.new(property_params)
    if @property.save
      render json: @property, status: :created
    else
      render json: { errors: @property.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @property.user_id == current_user.id
      if @property.update(property_params)
        render json: @property
      else
        render json: @property.errors, status: :unprocessable_entity
      end
    else
      render_unauthorized("Unauthorized")
    end
  end

  def destroy
    if @property.user_id == current_user.id
      @property.destroy
    else
      render_unauthorized("Unauthorized")
    end
  end

  

  private

  # Use callbacks to share common setup or constraints between actions.
  def property_params
    params.require(:property).permit(:operation_type, :pets, :maintenance, :bathrooms,
                                     :bedrooms, :property_type, :price, :photos, :about, :address, :active)
  end

  def set_property
    @property = Property.find(params[:id])
  end
end
