class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.find_for_facebook_oauth request.env["omniauth.auth"]
    if !@user.nil?
      session[:user_id] = @user.id
      render :json => "YES"
      # redirect_to root_path
    else
      render :json => "NO"
      # redirect_to :login
    end
  end

  def vkontakte
    @user = User.find_for_vkontakte_oauth request.env["omniauth.auth"]
    if !@user.nil?
      session[:user_id] = @user.id
      render :json => "YES"
    else
      render :json => "NO"
    end
  end
end