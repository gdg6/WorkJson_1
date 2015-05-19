class Tag < ActiveRecord::Base

  validates :context, :presence => true

  has_many :tags_to_characters
  has_many :characters, :through => :tags_to_characters
  has_many :events_to_tags
  has_many :events, :through => :events_to_tags
end
