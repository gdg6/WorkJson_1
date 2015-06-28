class Admin::Admin < ActiveRecord::Base
  ROLES = ["Администратор", "Контеншик"]
  has_secure_password

end
