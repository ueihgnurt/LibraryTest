# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      flash[:success] = I18n.t("Login success")
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now[:danger] = I18n.t("Invalid email/password combination")
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
