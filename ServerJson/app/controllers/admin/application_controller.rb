class Admin::ApplicationController < ActionController::Base
  layout 'admin/layouts/application'

  before_action :load_current_admin


  def check_auth
    !@current_admin.nil?
  end

  private

  def load_current_admin
    begin
      @current_admin = Admin::Admin.find(session[:admin_id])
    rescue
      redirect_to '/admins/login'
    end
  end

end
