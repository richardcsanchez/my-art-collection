class Artist < ActiveRecord::Base
  has_many :artworks
  has_many :genres, :through => :artworks
  has_many :collectors, :through => :artworks

end
