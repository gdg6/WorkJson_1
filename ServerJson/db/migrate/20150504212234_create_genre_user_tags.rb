class CreateGenreUserTags < ActiveRecord::Migration
  def change
    create_table :genre_user_tags do |t|
      t.string :title, :null => false

      t.timestamps
    end
  end
end
