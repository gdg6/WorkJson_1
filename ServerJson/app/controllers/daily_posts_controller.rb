# В тз сказано, что DailyPost должен существовать в единственном экхземлпяре.

class DailyPostsController < ApplicationController

  before_action :set_daily_post, :only => [:show, :update]
  before_action :check_admin, :except => [:show]

  def show
    render :json => {"daily_post" => @daily_post.context}
  end

  def update
    return create(params) if @daily_post.nil?
    @daily_post.context=params[:context] unless params[:context].nil?
    render :json => {'save_success' => (@daily_post.save ? 'SUCCESS' : 'FAIL') }
  end

  private

  def create(argv)
      @daily_post = DailyPost.new
      @daily_post.context = argv[:context]
      render :json => {'save_success' => (@daily_post.save ? 'SUCCESS' : 'FAIL') }
  end

  def set_daily_post
      @daily_post = DailyPost.last
      @daily_post = DailyPost.new if @daily_post.nil?
  end

end
