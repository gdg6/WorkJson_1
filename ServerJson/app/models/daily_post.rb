class DailyPost < ActiveRecord::Base
  validates :context, :presence => true, :length => {:maximum => 255}
end
