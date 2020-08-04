# frozen_string_literal: true

class FollowsController < ApplicationController
  def create
    @user = User.find_by(id: params[:format])
    current_user.follow(@user)
    redirect_back fallback_location: root_path
  end

  def destroy
    @user = Follow.find_by(followed_id: params[:format])
    current_user.unfollow(@user)
    redirect_back fallback_location: root_path
  end
end
