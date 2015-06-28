class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :login
      t.string :password_digest, null: false, :default => 0
      t.integer :role

      t.timestamps
    end
  end
end
