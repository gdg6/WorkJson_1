class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.find_for_facebook_oauth request.env["omniauth.auth"]
    if !@user.nil?
      session[:user_id] = @user.id
      render :json => {:success => "YES"}
    else
      render :json => {:success=> "NO"}
    end
  end

  def vkontakte
    @user = User.find_for_vkontakte_oauth request.env["omniauth.auth"]
    if !@user.nil?
      session[:user_id] = @user.id
      render :json => {:success => "YES"}
    else
      render :json => {:success => "NO"}
    end
  end
end