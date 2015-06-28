class CreateDailyPosts < ActiveRecord::Migration
  def change
    create_table :daily_posts do |t|
      t.string :context
      t.belongs_to :city, :index => true
      t.timestamps
    end
  end
end
