class AddColumnCityToDailyPost < ActiveRecord::Migration
  def change
    add_reference :daily_posts, :city, index: true
  end
end
