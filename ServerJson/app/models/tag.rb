class Tag < ActiveRecord::Base

  validates :context, :presence => true
  belongs_to :genre_tag
  belongs_to :user

  has_many :events_to_tags
  has_many :events, :through => :events_to_tags
end
