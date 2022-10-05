class UsersController < ApplicationController
  skip_before_action :require_login!, only: :create
  def index; end

  def new
    @user = User.new
  end

  def show
    render json: current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def user_params
    params.permit(:email, :password, :phone, :name, :role)
  end
end
