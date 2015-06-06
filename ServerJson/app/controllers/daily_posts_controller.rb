# В тз сказано, что DailyPost должен существовать в единственном экхземлпяре.

# Последняя правка - Разработчики под ios попросили изменить методы. Заколебали мелкими правками.
# Первоначально дали ошибочкое тз. Денег не платят. Потому тут последняя правка на отшибись.
class DailyPostsController < ApplicationController

  before_action :set_daily_post, :only => [:show]
  before_action :set_daily_post_1, :only => [:update]
  before_action :check_auth, :except => [:show_guest]
  before_action :check_admin, :except => [:show, :show_guest]

  def show_guest
    @daily_post = DailyPost.where("city_id = ?", params[:city_id].to_i).take
    return render :json => {"daily_post" => nil} if @daily_post.nil?
    render :json => {"daily_post" => @daily_post.context}
  end

  def show
    render :json => {"daily_post" => @daily_post.context}
  end

  def update
    return create if @daily_post.nil?
    @daily_post.context = params[:daily_post][:context] unless params[:daily_post][:context].nil?
    save_with_check(@daily_post)
  end

  private

  def create
    @daily_post = DailyPost.new(daily_post_params)
    save_with_check(@daily_post)
  end

  def set_daily_post
    @daily_post = DailyPost.where("city_id = ?", @current_user.city_id).take
    @daily_post = DailyPost.new if @daily_post.nil?
  end

  def set_daily_post_1
    @daily_post = DailyPost.where("city_id = ?", params[:daily_post][:city_id].to_i).take
  end

  def daily_post_params
    params.require(:daily_post).permit(:context, :city_id)
  end

end
