class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t| #UserId is id in table by default
      t.string  :Login, :unique=>true, :index=>true, :null=>false
      # t.string  :Email, :unique=>true, :index=>true, :null=>false
      t.string  :password_digest, :null=>false
      t.string  :CharacterName, :null=>false
      t.string  :City, :null=>false
      t.boolean :Admin, :null=>false

      # for vk and facebook
      # nickname:string provider:string url:string
      # t.string :nickname
      # t.string :provider
      # t.string :url

      t.timestamps
    end
  end
end
