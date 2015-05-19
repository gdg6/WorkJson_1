class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :context
      t.timestamps
    end
  end
end
