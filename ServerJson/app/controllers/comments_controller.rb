class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :check_auth

  # GET /comments
  # GET /comments.json
  def index
   return  render :json => Comment.select(:id, :body, :login, :updated_at).where(:event_id => params[:event_id].to_i).load
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    return render :json => @comment
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = @current_user.id
    render :json => {'save_success' =>  @comment.save ? 'SUCCESS' : 'FAIL'}
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy if @comment.user_id == @current_user.id or @current_user.admin
    render :json => {"destroy_success" => 'SUCCESS'}
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
