require 'bcrypt'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :update_password, :getCity, :setCity, :getCharacterName, :setCharacterName, :setLogin, :addAdmin, :deleteAdmin]
  before_action :check_auth, :except => [:new, :create]
  # FIXME must be check_edit for edit profile user. Is can do only self user or admin
  # before_action :check_edit, :only => []
  respond_to :json, :html

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(reg_params)
    @user.characterName = params[:registration][:characterName]
    save_success = @user.save
    session[:user_id] = @user_id if save_success
    render :json => {'reg' => save_success ? 'YES' : 'NO'}
  end

  include BCrypt

  def update_password
    old_pass = BCrypt::Password.create(params[:old_password])
    @user.password = params[:new_password] if old_pass == @user.password_digest
    render :json => {"save_success" => @user.save ? 'SUCCESS' : 'FAIL'}
  end

  def getCity
    render :json => {'city' => @user.city}
  end

  def setCity
    @user.city = params[:city] if params[:city] != nil
    render :json => {"save_success" => @user.save ? 'SUCCESS' : 'FAIL'}
  end


  def getCharacterName
    render :json => {'characterName' => @user.characterName}
  end

  def setCharacterName
    @user.characterName = params[:characterName] if params[:characterName] != nil
    render :json => {"save_success" => @user.save ? 'SUCCESS' : 'FAIL'}
  end

  def setLogin
    permit = false
    if @current_user == @user.id or @current_user.admin
      @user.login = params[:login] if !params[:login].nil?
      permit = @user.save
    end
    render :json => {"save_success" => permit ? 'SUCCESS' : 'FAIL'}
  end

  def addAdmin
    if @current_user.admin
      @user.admin = true
      return render :json => {"save_success" => @user.save ? 'SUCCESS' : 'FAIL'}
    end
    render :json => {"save_success" => 'FAIL', 'err' => 'NOT_ADMIN'}
  end

  def deleteAdmin
    if @current_user.admin and @current_user.id != @user.id
      @user.admin=false
      return render :json => {"save_success" => @user.save ? 'SUCCESS' : 'FAIL'}
    end
    render :json => {"save_success" => 'FAIL', 'err' => 'NOT_ADMIN'}
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    # authorize! :update, @user
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to @user, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    begin
      @user = User.find(params[:user_id])
    rescue
      return render :json => {"user" => "NOT_FOUND"}
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:login, :email, :password, :password_confirmation, :characterName, :city, :admin, :provider, :url)
  end

  def reg_params
    # raise params.to_s
    # ActiveSupport::JSON.decode(params.to_json).require(:registration).permit(:login, :email, :password, :password_confirmation, :characterName, :city, :admin, :provider, :url)
    params.require(:registration).permit(:login, :email, :password, :password_confirmation, :characterName, :city, :admin, :provider, :url)
  end
end
