class CreateFavorities < ActiveRecord::Migration
  def change
    create_table :favorities do |t|
      t.belongs_to :event, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
