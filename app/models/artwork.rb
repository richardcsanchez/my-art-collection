class Artwork < ActiveRecord::Base
  belongs_to :collector
  belongs_to :artist
  belongs_to :media
end
