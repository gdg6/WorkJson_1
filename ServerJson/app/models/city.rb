class City < ActiveRecord::Base
  has_many :users
  has_many :events
  has_many :daily_posts
end
