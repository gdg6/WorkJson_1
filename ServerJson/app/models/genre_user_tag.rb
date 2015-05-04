class GenreUserTag < ActiveRecord::Base
  validates :title, :uniqueness => true, :length => {:maximum => 255}
end
