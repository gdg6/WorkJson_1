class User < ActiveRecord::Base

  has_secure_password
  validates :login, uniqueness: true
  validates :password, length: {minimum: 6, allow_blank: true}
  # validates :admin, presence: true
  validates :sign_in_count, presence: true

  has_many :comments, dependent: :destroy
  has_many :services, :dependent => :destroy
  has_many :events, :dependent => :destroy
  has_many :favorities, :dependent => :destroy

  before_validation :set_default_sign_count
  #
  # # Include default devise modules. Others available are:
  # # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :confirmable, :lockable, :omniauth_providers => [:facebook, :vkontakte]
  devise :omniauthable, :omniauth_providers => [:facebook, :vkontakte]

  # # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :login, :provider, :url

  def self.find_for_facebook_oauth(access_token)
    user = User.where(:url => access_token.info.urls.Facebook).first
    return user if user
    begin    
      u = User.new
        u.provider = access_token.provider
        u.url = access_token.info.urls.Facebook
        u.login = access_token.extra.raw_info.name
        u.characterName = access_token.extra.raw_info.first_name
        u.email = access_token.extra.raw_info.email
        u.password = Devise.friendly_token[0,20]
      u.save!      
    rescue Exception => e
      return nil
    end
    return u
  end


  def self.find_for_vkontakte_oauth(access_token)
    #    code"=>"27130c3fba500ecd0e",
    # "state"=>"4d1cb76be48973faf7061ff88b7671a108eddce4ae75658f"
    user = User.where(:url => access_token.info.urls.Vkontakte).first
    return user if user
    # begin
    raise access_token.to_s
      u = User.new
        u.provider = access_token.provider
        u.url = access_token.info.urls.Vkontakte
        u.login = access_token.extra.raw_info.screen_name
        u.characterName = access_token.extra.raw_info.first_name
        u.email = ("https://vk.com/write" + access_token.uid.to_s) # vk don't give email :(
        u.password = Devise.friendly_token[0,20]
      raise u.email
      u.save!

    # rescue Exception => e
      # return nil
    # end
    # return u
  end


  def admin?
    return self.admin
  end

  def self.edit?(u)
    u && u.admin?
    return 1
  end

  private

  def set_default_sign_count
    self.sign_in_count ||= 0
  end


end
