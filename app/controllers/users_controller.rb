class UsersController < ApplicationController
  skip_before_action :require_login, except: [:show, :edit, :update, :destroy]
  before_action :require_id_match, except: [:create]

  # registers new user account
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/products"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/sessions/new"
    end
  end

  # displays page that allows user to update personal info
  def edit
    @user = User.find(params[:id])
  end

  # updates user's personal info
  def update
    @user = User.find(params[:id])
    if !params[:user][:password].blank?
      if @user.update(user_params)
        redirect_to "/products"
      else
        flash[:errors] = @user.errors.full_messages
        redirect_to "/users/#{@user.id}/edit"
      end
    else
      if @user.update(user_params)
        redirect_to "/products"
      else
        flash[:errors] = @user.errors.full_messages
        redirect_to "/users/#{@user.id}/edit"
      end
    end
  end

  # deletes user account
  def destroy
    User.find(params[:id]).destroy
    session[:user_id] = nil
    redirect_to "/sessions/new"
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    def require_id_match
      if current_user != User.find(params[:id])
        redirect_to "/products"
      end
    end
end
