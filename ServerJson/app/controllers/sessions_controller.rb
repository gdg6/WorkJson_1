require 'json'

class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.where("login=? OR email=?", params[:login], params[:login]).take
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      render :json => {"auth" => "YES"}
    else
      render :json => {"auth" => "NO"}
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to :login
  end

 end
