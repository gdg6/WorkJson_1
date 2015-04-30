class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :event, :index => true #EventId
      t.belongs_to :user, :index => true  #OwnerUser
      t.string :Body, :null => false

      t.timestamps
    end
  end
end
