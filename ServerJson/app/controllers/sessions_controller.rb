require 'json'
class SessionsController < ApplicationController

  def new
  end

  def create
    @user=User.where("Login=? OR Email=?", params[:Login], params[:Login]).take
    if @user && @user.authenticate(params[:Password])
      session[:user_id]=@user.id
       # json = JSON.generate ["YES"]
       # return json
      redirect_to root_path, notice: 'Вход выполнен'
    else
      flash[:danger]='Неверное имя пользователя или пароль'
      render :new
      # return  JSON.generate ["NO"]
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to :login, notice: 'Выход выполнен'
  end
 end
