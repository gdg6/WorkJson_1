class User < ActiveRecord::Base

  has_many :comments, dependent: :destroy

  ROLES=["Пользователь", "Администратор"]

  has_secure_password
  validates :Login, uniqueness: true
  validates :Password, length: {minimum: 6, allow_blank: true}
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
