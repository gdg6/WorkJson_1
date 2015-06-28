module Admin::ApplicationHelper
  def ROLES(id)
    roles= ["Администратор", "Контентщик"]
    roles[id]
  end
end
