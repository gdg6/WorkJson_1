module Admin::AdminsHelper


  def ROLES(id)
    roles= ["Администратор", "Контентщик"]
    roles[id]
  end

  def get_list_roles
    [["Администратор", 0],["Контентщик", 1]]
  end


end
