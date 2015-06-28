class Admin::Admin < ActiveRecord::Base

  has_secure_password

  before_validation :set_defaulte_role

  def set_defaulte_role
    self.role ||= 0
  end

  attr_accessor :roles

end
