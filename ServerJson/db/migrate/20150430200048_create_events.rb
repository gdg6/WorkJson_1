class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :EventId
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
