class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :title
      t.timestamps
    end
  end
end
