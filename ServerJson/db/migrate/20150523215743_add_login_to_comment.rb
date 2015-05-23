class AddLoginToComment < ActiveRecord::Migration
  def change
    #Duplication of information to speed up response
    add_column :comments, :login, :string
  end
end
