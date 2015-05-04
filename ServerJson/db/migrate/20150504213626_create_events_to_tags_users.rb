class CreateEventsToTagsUsers < ActiveRecord::Migration
  def change
    create_table :events_to_tags_users do |t|
      t.belongs_to :tags_user, :index =>  true
      t.belongs_to :event, :index => true
      t.timestamps
    end
  end
end
