class EventsToTagsUser < ActiveRecord::Base
  belongs_to :event
  belongs_to :tags_user
end
