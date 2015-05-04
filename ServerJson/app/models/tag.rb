class Tag < ActiveRecord::Base
  belongs_to :genre_tag
  has_many :events_to_tags
  has_many :events, :through => :events_to_tags
end
