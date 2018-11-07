class Artist < ActiveRecord::Base
  has_many :artworks
  has_many :mediums, :through :artworks
end
