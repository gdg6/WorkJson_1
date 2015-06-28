class Admin::ThemesController < Admin::ApplicationController
  before_action :check_auth

  def index
    @themes = Theme.page(params[:page]).per(30).load
  end

  def show

  end

  def update

  end

  def destroy

  end

end
