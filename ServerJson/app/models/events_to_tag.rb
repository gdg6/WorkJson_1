class EventsToTag < ActiveRecord::Base
  belongs_to :event
  belongs_to :tag
end
