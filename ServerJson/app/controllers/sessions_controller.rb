require 'json'

class SessionsController < ApplicationController

  def new
  end

  def create
    @user=User.where("login=? OR email=?", params[:login], params[:login]).take
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      # redirect_to root_path
      render :json => ["YES"]
    else
      render :json => "NO"
      # return  JSON.generate ["NO"]
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to :login
  end

 end
