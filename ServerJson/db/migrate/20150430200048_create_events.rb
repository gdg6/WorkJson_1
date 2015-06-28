class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :user, :index => true
      t.string :name
      t.string :adress
      t.integer :date, :index => true
      t.string :time
      t.string :description, limit: 300
      t.integer :price
      t.integer :popularity
      t.belongs_to :city, :index => true
      t.string :url
      t.float :longitude
      t.float :latitude
      t.attachment :picture

      t.timestamps
    end
  end
end
