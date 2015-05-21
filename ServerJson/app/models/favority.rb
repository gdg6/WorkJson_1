class Favority < ActiveRecord::Base
  belongs_to :event
  belongs_to :user
  after_save :increment_popularity_event
  before_destroy :decrement_popularity_event

  private

  def increment_popularity_event
    event = Event.where(:id => self.event_id).take
    return unless event
    event.popularity += 1
    event.save
  end

  def decrement_popularity_event
    event = Event.where(:id => self.event_id).take
    return unless event
    event.popularity -= 1
    event.save
  end

end
