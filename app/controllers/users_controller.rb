# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :load_user, except: %i[index new create]
  before_action :logged_in_user, except: %i[new show create]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.lastest.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:info] = I18n.t('Please check your email to activate your account.')
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = I18n.t('Profile updated')
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = I18n.t('User deleted')
      console.log('aaaa')
    else
      flash[:error] = I18n.t('delete fails')
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = I18n.t('Please log in.')
      redirect_to login_url
    end
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warming] = I18n.t('user not found')
    redirect_to root_path
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
