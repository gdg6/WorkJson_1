class Event < ActiveRecord::Base
	# has_many :comments, dependent: :destroy
  #
	# has_many :events_to_tags_users
	# has_many :tags_users, :through => :events_to_tags_users
  #
	# has_many :events_to_tags
	# has_many :tags, :through => :events_to_tags

	has_attached_file :picture, :styles => { :medium => "300x300", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
	validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

end
