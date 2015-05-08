class CreateDailyPosts < ActiveRecord::Migration
  def change
    create_table :daily_posts do |t|
      t.string :context

      t.timestamps
    end
  end
end
