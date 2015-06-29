class Admin::UsersController < Admin::ApplicationController

  before_action :check_auth
  before_action :set_user, :except => [:index]

  def index
    @users = User.page(params[:page]).per(30).load
  end

  def show

  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to '/admin/users', notice: 'Admin was successfully destroyed.' }
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params) then
        format.html { redirect_to '/admin/users', notice: 'Comment was successfully updated.' }
    else
      format.html { render :'admin/admins/edit'}
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def email_valid (user)
    user.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end

  def user_params
    params.require(:user).permit(:login, :email, :password, :password_confirmation, :character_id, :city_id, :admin, :provider, :url)
  end

end
