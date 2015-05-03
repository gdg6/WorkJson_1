class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :confirmable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :nickname, :provider, :url, :username

  def self.find_for_facebook_oauth access_token
    if user = User.where(:url => access_token.info.urls.Facebook).first
      user
    else
      # создание модели не корректно из-за неверных аргументов. Но сюда программа не доходит
      User.create!(:provider => access_token.provider, :url => access_token.info.urls.Facebook, :username => access_token.extra.raw_info.name, :nickname => access_token.extra.raw_info.username, :email => access_token.extra.raw_info.email, :password => Devise.friendly_token[0,20])
    end
  end

  def self.find_for_vkontakte_oauth access_token
    if user = User.where(:url => access_token.info.urls.Vkontakte).first
      user
    else
      User.create!(:provider => access_token.provider, :url => access_token.info.urls.Vkontakte, :username => access_token.info.name, :nickname => access_token.extra.raw_info.domain, :email => access_token.extra.raw_info.domain+'<hh user=vk>.com', :password => Devise.friendly_token[0,20])
    end
  end


  has_many :comments, dependent: :destroy
  has_many :services, :dependent => :destroy
  has_many :events, :dependent => :destroy

  ROLES=["Пользователь", "Администратор"]

  has_secure_password
  validates :Login, uniqueness: true
  validates :password, length: {minimum: 6, allow_blank: true}
  validates :Admin, presence: true

  before_validation :set_default_role

  def set_default_role
    self.Admin||=false
  end

  def admin?
    Admin==true
  end

  def self.edit?(u)
    u && u.Admin?
    return 1
  end

end
