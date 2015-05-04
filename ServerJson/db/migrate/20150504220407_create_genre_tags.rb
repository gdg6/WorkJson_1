class CreateGenreTags < ActiveRecord::Migration
  def change
    create_table :genre_tags do |t|
      t.string :title

      t.timestamps
    end
  end
end
