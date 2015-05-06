class ApplicationController < ActionController::Base

  before_action :load_current_user

  def load_current_user
    @current_user = User.where(id: session[:user_id].to_i).take
  end

  def check_auth
    render :json => {:success => "NO_AUTH"} unless @current_user
  end
  
  def check_admin
    return @current_user.admin
  end

  def render_error(url,msg="Доступ запрещен")
    flash[:danger] = msg
    redirect_to url
  end

  def ensure_signup_complete
    return if action_name == 'finish_signup'
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

end
