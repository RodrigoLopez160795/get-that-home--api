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

  def update
    if current_user.update(user_params)
      render json: current_user, status: :ok
    else
      render json: { errors: current_user.errors }, status: :unprocessable_entity
    end
  end

  delegate :destroy, to: :current_user

  private

  # Use callbacks to share common setup or constraints between actions.
  def user_params
    params.permit(:email, :password, :phone, :name, :role)
  end
end
