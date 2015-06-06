class DailyPost < ActiveRecord::Base
  validates :context, :presence => true, :length => {:maximum => 255}
  belongs_to :city

end
