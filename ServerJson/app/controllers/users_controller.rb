require 'bcrypt'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_auth, :except => [:new, :create]
  before_action :set_user_by_current, :only => [:update_password, :getCity, :setCity, :getCharacterName, :setCharacterName, :setLogin, :addAdmin, :deleteAdmin]

  # FIXME must be check_edit for edit profile user. Is can do only self user or admin
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

  #FIXME - must be refactoring
  # POST /users
  # POST /users.json
  def create
    @user = User.new(reg_params)
    @user.city_id = params[:registration][:city_id].to_i
    @user.character_id = params[:character_id].to_i > 0 ? params[:character_id].to_i : create_character(params[:character]).to_i
    return render :json => {'reg' => 'NO', 'err' => 'NO_VALID_EMAIL'} unless email_valid(@user)
    unless uniq_user(params)
      return render :json => {'reg' => 'NO', 'err' => 'REPLACE_LOGIN_OR_EMAIL'}
    end
    save_success = false
    if !params[:soc].nil?
      soc = create_by_soc(@user, params[:soc])
      if soc == 0
        save_success = @user.save
        session[:user_id] = @user_id if save_success
      elsif soc == 1
        @err = 'NO_CORRECT_ACCESS_TOKEN'
      elsif soc == 2
        @err = 'USER_SOC_REPLACE'
      end
      return render :json => {'reg' => (save_success ? 'YES' : 'NO'), 'err' => @err}
    end
    save_success = @user.save
    session[:user_id] = @user_id if save_success
    return render :json => {'reg' => (save_success ? 'YES' : 'NO'), 'err' => @err}
  end

  include BCrypt

  def update_password
    old_pass = BCrypt::Password.create(params[:old_password])
    @user.password = params[:new_password] if old_pass == @user.password_digest
    save_with_check(@user)
  end

  def getCity
    render :json => {'city' => @user.city}
  end

  def setCity
    @user.city = params[:city].to_i if params[:city] != nil
    save_with_check(@user)
  end


  def getCharacterName
    render :json => {'characterName' => @user.characterName}
  end

  def setCharacterName
    @user.characterName = params[:characterName] if params[:characterName] != nil
    save_with_check(@user)
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
      return save_with_check(@user)
    end
    render :json => {"save_success" => 'FAIL', 'err' => 'NOT_ADMIN'}
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

  def uniq_user(argv)
    return User.where("login = ? OR email = ?", argv[:registration][:login], argv[:registration][:email]).take.nil? ? true : false
  end

  def create_by_soc(user, argv)
    BCrypt::Engine.hash_secret(argv[:id].to_s, "$2a$10$TlxTfAg8QmFMzuY97EiTJu") == argv[:access_token].to_s
    return 3 if argv[:type] != 'fb' && argv[:type] != 'vk'
    user.provider_user_id = argv[:id].to_i
    user.provider = argv[:type]
    tmp_user = User.where("provider_user_id  = ? AND provider = ?", argv[:id], argv[:type]).take
    tmp_user.nil? ? (user.provider_user_id > 0 ? 0 : 1) : 2
  end

  def create_character(argv)
    return nil if argv.nil?
    @character = Character.new
    @character.title='user'
    @character.save
    tags_ids = []
    TagsToCharacter.select(:tag_id).where("character_id IN (?)", argv[:character_arr].split(", ")).load.each { |x| tags_ids << x.tag_id.to_i }
    tags_ids.each do |x|
      @TTC = TagsToCharacter.new
      @TTC.tag_id = x.to_i
      @TTC.character_id=@character.id
      @TTC.save
    end
    return @character.id
  end

  def set_user_by_current
    @user = @current_user
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    begin
      @user = User.find(params[:user_id])
    rescue
      return render :json => {"user" => "NOT_FOUND"}
    end
  end

  def email_valid (user)
    return user.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:login, :email, :password, :password_confirmation, :character_id, :city, :admin, :provider, :url)
  end

  def reg_params
    params.require(:registration).permit(:login, :email, :password, :password_confirmation)
  end
end
