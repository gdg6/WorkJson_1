class CreateTagsToCharacters < ActiveRecord::Migration
  def change
    create_table :tags_to_characters do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :character, index: true
      t.timestamps
    end
  end
end
