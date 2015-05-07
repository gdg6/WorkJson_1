class ApplicationController < ActionController::Base
  attr_reader :err
  before_action :load_current_user
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found_404
  rescue_from ActionView::MissingTemplate, :with => :missing_tamplete

  def load_current_user
    @current_user = User.where(id: session[:user_id].to_i).take
  end

  def check_auth
    return render :json => {"succes" => "NO_AUTH"} unless @current_user
  end
  
  def check_admin
    return @current_user.admin
  end

  def not_found_404
    return render :json => {"page"=>"404"}
  end

  def missing_tamplete
    return render :json => {"page" => "TEMPLATE_MISSING"}
  end

  def ensure_signup_complete
    return if action_name == 'finish_signup'
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

end
