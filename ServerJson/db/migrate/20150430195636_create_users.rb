class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t| #UserId is id in table by default
      t.string  :login, :unique => true, :index => true, :null => false
      t.string  :password_digest, :null => false
      t.string  :characterName, :null => false
      t.integer  :city, :default => 0
      t.boolean :admin, :default => false

      # for vk and facebook
      t.string :provider
      t.string :url

      t.timestamps
    end
  end
end
