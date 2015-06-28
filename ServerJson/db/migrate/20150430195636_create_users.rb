class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t| #UserId is id in table by default
      t.string     :login,           :unique => true, :index => true, :null => false
      t.string     :password_digest, :null => false
      t.belongs_to :character,       :index => true, :null => false
      t.belongs_to :city,            :index => true
      t.boolean    :active,           :default => true

      # for vk and facebook
      t.string :provider
      t.integer :provider_user_id, :index => true

      t.timestamps
    end
  end
end
