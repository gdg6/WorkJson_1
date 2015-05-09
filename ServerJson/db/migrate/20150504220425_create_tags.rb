class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :context
      t.belongs_to :genre_tag, :index => true
      t.belongs_to :user, :index => true
      t.timestamps
    end
  end
end
