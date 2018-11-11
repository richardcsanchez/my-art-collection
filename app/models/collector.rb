class Collector < ActiveRecord::Base
  has_secure_password
  has_many :artworks
  has_many :artists, :through => :artworks
  has_many :genres, :through => :artworks

  def slug
      username.downcase.gsub(" ","-")
    end

     def self.find_by_slug(slug)
      Collector.all.find {|user| user.slug == slug }
    end

end
