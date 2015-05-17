class Event < ActiveRecord::Base

	has_many :comments, dependent: :destroy
	has_many :favorities, :dependent => :destroy
	has_many :events_to_tags, :dependent => :destroy
	has_many :tags, :through => :events_to_tags

	has_attached_file :picture, :styles => { :medium => "1024x760", :thumb => "300x300>" }, :default_url => "missing.png"
	validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/, attachment_size: { less_than: 5.megabytes }
end
