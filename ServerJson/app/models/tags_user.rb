class TagsUser < ActiveRecord::Base
  belongs_to :genre_user_tag
  belongs_to :user
  has_many :events_to_tags_users
  has_many :events, :through => :events_to_tags_users
end
