class DailyPost < ActiveRecord::Base
  validate :description_length

  private

  def description_length
    return false if :context.blank? or :context.length > 255
    return true
  end

end
