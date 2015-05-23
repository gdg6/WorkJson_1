class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :event
 	validates :body, presence: true, :length => {:maximum => 255}
	before_create :set_user_params

	private

	def set_user_params
		self.user_id = @current_user.id
		self.login = @current_user.login
	end

end
