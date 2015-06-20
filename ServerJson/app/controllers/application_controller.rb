class ApplicationController < ActionController::Base
  attr_reader :err
  before_action :load_current_user
  rescue_from ActiveRecord::RecordNotFound, :with => :not_found_404
  rescue_from ActionView::MissingTemplate, :with => :missing_tamplete
  rescue_from Exception, :with => :exception_500

  def load_current_user
    @current_user = User.where(:id => session[:user_id]).take
  end

  def check_auth
    return render :json => {"succes" => "NO_AUTH"} unless @current_user
  end
  
  def check_admin
    return render :json => {"succes" => "NO_ADMIN"} unless @current_user.admin
  end

  def exception_500
    return render :json => {'page' => '500'}
  end

  def not_found_404
    return render :json => {"page" => "404"}
  end

  def missing_tamplete
    return render :json => {"page" => "TEMPLATE_MISSING"}
  end

  def save_with_check(obj)
    render :json => {"save_success" => obj.save ? 'SUCCESS' : 'FAIL', 'err' => @err}
  end

end
