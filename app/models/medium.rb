class Medium < ActiveRecord::Base
  has_many :artworks
  has_many :artists, :through => :artworks

end
