class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :load_current_user
  before_action :setYear

  attr_reader :Year

  private

  def setYear
    @Year = Time.new.year
  end

  def load_current_user
    @current_user = User.where(id: session[:user_id].to_i).take
  end

  def check_auth
    render_error(login_path,"Доступ без авторизации запрещен") unless @current_user
  end
  
  def render_error(url,msg="Доступ запрещен")
    flash[:danger] = msg
    redirect_to url
  end


  def ensure_signup_complete
    # Ensure we don't go into an infinite loop
    return if action_name == 'finish_signup'

    # Redirect to the 'finish_signup' page if the user
    # email hasn't been verified yet
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

end
