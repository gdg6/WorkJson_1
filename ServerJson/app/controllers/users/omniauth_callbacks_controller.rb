class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.find_for_facebook_oauth request.env["omniauth.auth"]
    if !@user.nil?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      # sign_in_and_redirect @user, :event => :authentication
      redirect_to root_path

    else
      flash[:notice] = "authentication error"
      redirect_to :login
    end
  end

  def vkontakte
    @user = User.find_for_vkontakte_oauth request.env["omniauth.auth"]
    if !@user.nil?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Vkontakte"
      # sign_in_and_redirect @user, :event => :authentication
      redirect_to root_path
    else
      flash[:notice] = "authentication error"
      redirect_to :login
    end
  end
end