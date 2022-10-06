class SavedPropertiesController < ApplicationController
  before_action :set_saved_property, only: %i[update destroy]
  before_action :require_login!
  def new
    @saved_property = SavedProperty.new
  end

  def create
    @saved_property = current_user.savedProperties.new(saved_property_params)
    if @saved_property.save
      render json: @saved_property, status: :created
    else
      render json: { errors: @saved_property.errors }, status: :unprocessable_entity
    end
  end

  def my_saved_properties
    @saved_properties = current_user.savedProperties
    render json: @saved_properties
  end

  def edit; end

  def update
    if @saved_property.user_id == current_user.id
      if @saved_property.update(saved_property_params)
        render json: @saved_property
      else
        render json: @saved_property.errors, status: :unprocessable_entity
      end
    else
      render_unauthorized("Unauthorized")
    end
  end

  def destroy
    if @saved_property.user_id == current_user.id
      @saved_property.destroy
    else
      render_unauthorized("Unauthorized")
    end
  end

  private

  def saved_property_params
    params.require(:saved_property).permit(:favorite, :contacted, :property_id, :user_id)
  end

  def set_saved_property
    @saved_property = SavedProperty.find(params[:id])
  end
end
