class CreateAdminAdmins < ActiveRecord::Migration
  def change
    create_table :admin_admins do |t|
      t.string :login
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
