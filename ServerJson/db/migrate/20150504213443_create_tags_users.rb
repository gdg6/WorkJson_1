class CreateTagsUsers < ActiveRecord::Migration
  def change
    create_table :tags_users do |t|
      t.belongs_to :genre_user_tag, :index => true
      t.belongs_to :user, :index => true
      t.string :context
      t.timestamps
    end
  end
end
