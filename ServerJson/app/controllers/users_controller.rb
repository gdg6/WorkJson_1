require 'bcrypt'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit,  :destroy, :add_admin, :delete_admin]
  before_action :check_auth, :except => [:new, :create, :get_profile_info, :set_character, :set_city, :set_password]
  before_action :check_admin, :only => [:destroy]

  # FIXME must be check_edit for edit profile user. Is can do only self user or admin
  respond_to :json, :html


  # GET /users/new
  def new
    @user = User.new
  end

  #FIXME - must be refactoring
  # POST /users
  # POST /users.json
  def create
    @user = User.new(reg_params)
    @user.character_id = params[:character_id].to_i == 0 ? create_character(params[:character]).to_i :  params[:character_id].to_i
    return render json: {'reg' => 'NO', 'err' => 'NO_VALID_EMAIL'} unless email_valid(@user)
    return render json: {'reg' => 'NO', 'err' => 'BAD_CHARACTER'} if @user.character_id == 0
    unless uniq_user(params)
      return render json: {'reg' => 'NO', 'err' => 'REPLACE_LOGIN_OR_EMAIL'}
    end
    save_success = false
    unless params[:soc].nil?
      soc = create_by_soc(@user, params[:soc])
      if soc == 0
        save_success = @user.save
        session[:user_id] = @user.id if save_success
      elsif soc == 1
        @err = 'NO_CORRECT_ACCESS_TOKEN'
      elsif soc == 2
        @err = 'USER_SOC_REPLACE'
      end
      return render json: {'reg' => (save_success ? 'YES' : 'NO'), 'err' => @err}
    end
    save_success = @user.save
    session[:user_id] = @user_id if save_success
    render json: {'reg' => (save_success ? 'YES' : 'NO'), 'err' => @err}
  end

  include BCrypt


  #get profile current user. Only select field
  #character must be valid
  def get_profile_info
    res = {}
    res[:user] = User.select(:login, :city_id, :email, :admin).where(id: session[:user_id]).take
    res[:character] = Character.select(:id, :title).where(id: @current_user.character_id).take
    render json: res
  end

  def set_password
    #old_pass = BCrypt::Password.create(params[:old_password])
    @err = 'NOT_EQUAL_PASS_AND_CONF' unless params[:new_password] == params[:confirm_password]
    #@err = 'OLD_PASSWORD' unless old_pass == @current_user.password_digest
    return render json: {'save_success' => 'FAIL', 'err' => @err} unless @err
    @current_user.password = params[:new_password]
    save_with_check(@current_user)
  end

  def set_city
    @current_user.city_id = params[:city_id].to_i if params[:city_id] != nil
    save_with_check(@current_user)
  end

  def set_character
    @current_user.character_id = params[:character_id].to_i if params[:character_id] != nil
    save_with_check(@current_user)
  end

  def add_admin
    if @current_user.admin
      @user.admin = true
      return render :json => {"save_success" => @user.save ? 'SUCCESS' : 'FAIL'}
    end
    render json: {"save_success" => 'FAIL', 'err' => 'NOT_ADMIN'}
  end

  def delete_admin
    if @current_user.admin and @current_user.id != @user.id
      @user.admin = false
      return save_with_check(@user)
    end
    render json: {"save_success" => 'FAIL', 'err' => 'NOT_ADMIN'}
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
    User.where('login = ? OR email = ?', argv[:registration][:login], argv[:registration][:email]).take ? false : true
  end

  def create_by_soc(user, argv)
    BCrypt::Engine.hash_secret(argv[:id].to_s, '$2a$10$TlxTfAg8QmFMzuY97EiTJu') == argv[:access_token].to_s
    return 3 if argv[:type] != 'fb' && argv[:type] != 'vk'
    user.provider_user_id = argv[:id].to_i
    user.provider = argv[:type]
    tmp_user = User.where('provider_user_id  = ? AND provider = ?', argv[:id], argv[:type]).take
    tmp_user ? 2 : (user.provider_user_id > 0 ? 0 : 1)
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
    @character.id
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
      @user = User.where(params[:user_id]).take
      render json: {'user' => 'NOT_FOUND'} unless @user
  end

  def email_valid (user)
    user.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:login, :email, :password, :password_confirmation, :character_id, :city, :admin, :provider, :url)
  end

  def reg_params
    params.require(:registration).permit(:login, :email, :password, :password_confirmation, :city_id)
  end
end
