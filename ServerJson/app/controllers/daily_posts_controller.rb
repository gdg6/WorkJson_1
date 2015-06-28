class DailyPostsController < ApplicationController

  before_action :set_daily_post, :only => [:show]
  before_action :check_auth, :except => [:show_guest]

  def show_guest
    @daily_post = DailyPost.where("city_id = ?", params[:city_id].to_i).take
    return render :json => {"daily_post" => nil} if @daily_post.nil?
    render :json => {"daily_post" => @daily_post.context}
  end

  def show
    render :json => {"daily_post" => @daily_post.context}
  end

  private

  def set_daily_post
    @daily_post = DailyPost.where("city_id = ?", @current_user.city_id).take
    @daily_post = DailyPost.new if @daily_post.nil?
  end

end
