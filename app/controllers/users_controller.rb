class UsersController < ApplicationController
  before_action :authorize
  skip_before_action :authorize, only: [:create]

  def create
      user = User.create!(user_params)
      if user.valid?
          session[:user_id] = user.id
          render json: user, status: 201
      else
          rendor json: {errors: "User invalid"}, status: 422
      end
  end

  def show
      user = User.find(session[:user_id])
      if user
          render json: user
      else
          render json: {error: "User not found"}, status: 401
      end
  end


  private

  def user_params
      params.permit(:username, :password, :password_confirmation, :image_url, :bio)
  end

  def authorize
      render json: {errors: ["Not authorized"]}, status: 401 unless session.include? :user_id
  end
end
