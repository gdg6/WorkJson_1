class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :UserId, :unique=>true, :index=>true
      t.string  :Login, :unique=>true, :index=>true, :null=>false
      t.string  :Email, :unique=>true, :index=>true, :null=>false
      t.string  :password_digest, :null=>false
      t.string  :CharacterName, :null=>false
      t.string  :City, :null=>false
      t.boolean :Admin, :null=>false

      t.timestamps
    end
  end
end
