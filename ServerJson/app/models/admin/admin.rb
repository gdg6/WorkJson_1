class Admin::Admin < ActiveRecord::Base
  roles = ["Администратор", "Контеншик"]
  has_secure_password
  after_initialize :set_defaulte_role

  def set_defaulte_role
    self.role |= 0
  end


  def self.ROLES
    roles[self.role.to_i]
  end

end
