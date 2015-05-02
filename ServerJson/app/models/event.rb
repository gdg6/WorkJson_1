class Event < ActiveRecord::Base
	has_many :comments, dependent: :destroy

	has_attached_file :Image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	validates_attachment_content_type :Image, :content_type => /\Aimage\/.*\Z/

end
