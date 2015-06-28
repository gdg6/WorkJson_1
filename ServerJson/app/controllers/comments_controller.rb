class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :destroy]
  before_action :check_auth

  # GET /comments
  # GET /comments.json
  def index
   return  render :json => Comment.select(:id, :body, :login, :updated_at).where(:event_id => params[:event_id].to_i).load
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = @current_user.id
    save_with_check(@comment)
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    render :json => {"destroy_success" => (@comment.destroy ? 'SUCCESS' : 'FAIL'), 'err' => error.to_s} if @comment.user_id == @current_user.id
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:event_id, :body, :login)
    end
end
