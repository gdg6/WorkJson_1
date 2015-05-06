class Comment < ActiveRecord::Base

	belongs_to :user
	belongs_to :event
 	validates :Body, presence: true, :length => {:maximum => 255}
 	
end
