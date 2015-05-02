class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :user, :index => true
      t.string :Name
      t.string :Adress
      t.string :Date
      t.string :Time
      t.string :Description
      t.integer :Price
      t.integer :Popularity

      t.timestamps
    end
  end
end
