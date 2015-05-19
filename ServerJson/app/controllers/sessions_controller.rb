require 'json'

#Здесь происходит именно авторизация а не регистрация пользователей
class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.where("login=? OR email=?", params[:login], params[:login]).take
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      render :json => {:success => "YES"}
    else
      render :json => {:success => "NO"}
    end
  end

  def create_by_social
    return render :json => {:success => "NO"} if params[:soc].nil?
    return render :json => {:success => "NO"} if BCrypt::Engine.hash_secret(params[:provider_user_id].to_i, "$2a$10$TlxTfAg8QmFMzuY97EiTJu") != params[:access_token]
    if params[:soc] == 'vk' || params[:soc] == 'fb'
      @user = User.where('provider_user_id = ? AND provider = ?', params[:provider_user_id].to_i, params[:soc]).take
    end
    session[:user_id] = @user.id if !@user.nil?
    render :json => {:success => (@user.nil? ? 'NO' : 'YES')}
  end

  def destroy
    session.delete(:user_id)
    # render :json => {"auth" => "LOGOUT"}
    redirect_to :login
  end

end
