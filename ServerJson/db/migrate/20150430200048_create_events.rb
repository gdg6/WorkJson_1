class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :user, :index => true
      t.string :name
      t.string :adress
      # civil_from_format(utc_or_local, year, month=1, day=1, hour=0, min=0, sec=0)
      t.datetime :start_date, :index => true
      t.datetime :end_date, :index => true

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
