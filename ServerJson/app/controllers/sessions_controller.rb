require 'json'

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

  def destroy
    session.delete(:user_id)
    # render :json => {"auth" => "LOGOUT"}
    redirect_to :login
  end

 end
