class TagsToCharacter < ActiveRecord::Base
  belongs_to :tag
  belongs_to :character
end
