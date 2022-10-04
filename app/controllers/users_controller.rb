class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def show
  end

  def mario
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def user_params
    params.require(:user).permit(:email, :phone, :name, :password, :role)
  end

end
