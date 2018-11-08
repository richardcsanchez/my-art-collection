class Collector < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  has_secure_password
  has_many :artworks
  has_many :artists, :through => :artworks
  has_many :mediums, :through => :artworks

end
