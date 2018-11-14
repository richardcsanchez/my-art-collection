class Artwork < ActiveRecord::Base
  belongs_to :collector
  belongs_to :artist
  belongs_to :genre

  def self.verify_collector?
    Artwork.all.each do |artwork|
    if artwork.collector == Helpers.current_user(session)
      "<ul><%=artwork.artist.name%> : <%=artwork.title%></ul>"
      "<a href='/artworks/<%=artwork.id%>'>View More</a> &nbsp; </ul>
      </form>"
    else nil
    end
  end
  end

end
