class Admin::SessionsController < Admin::ApplicationController

  skip_filter :load_current_admin

  def new
  end

  def create
    @admin = Admin::Admin.where("login=?", params[:login]).take
    if @admin && @admin.authenticate(params[:password])
      session[:admin_id] = @admin.id
      redirect_to '/admin'
    else
      redirect_to '/admin/login'
    end
  end

  def destroy
    session.delete(:admin_id)
    redirect_to '/admin/login'
  end

end
