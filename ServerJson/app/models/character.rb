class Character < ActiveRecord::Base
  has_many :tags_to_characters
  has_many :tags, :through => :tags_to_characters
end
