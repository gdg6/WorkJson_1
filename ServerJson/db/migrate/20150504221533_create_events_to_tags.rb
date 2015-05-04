class CreateEventsToTags < ActiveRecord::Migration
  def change
    create_table :events_to_tags do |t|
      t.belongs_to :event, :index => true
      t.belongs_to :tag, :index => true
      t.timestamps
    end
  end
end
