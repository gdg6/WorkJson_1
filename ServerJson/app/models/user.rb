class User < ActiveRecord::Base

  has_secure_password
  validates :login, uniqueness: true
  validates :password, length: {minimum: 6, allow_blank: true}
  validates :sign_in_count, presence: true
  validates :email, uniqueness: true, on: :create

  belongs_to :city
  belongs_to :character
  has_many :comments, dependent: :destroy
  has_many :services, :dependent => :destroy
  has_many :events, :dependent => :destroy
  has_many :favorities, :dependent => :destroy
  has_many :events, :through => :favorities

  before_validation :set_default_sign_count

  # # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :login, :provider, :url


  def admin?
    return self.admin
  end

  def self.edit?(u)
    return u && u.admin?
  end

  private

  def set_default_sign_count
    self.sign_in_count ||= 0
  end

end
