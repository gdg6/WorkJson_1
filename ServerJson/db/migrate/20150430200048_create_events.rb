class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :user, :index => true
      t.string :name
      t.string :adress
      t.integer :date, :index => true
      t.string :time
      t.string :description
      t.integer :price
      t.integer :popularity
      t.belongs_to :city, :index => true
      t.string :url

      t.timestamps
    end
  end
end
