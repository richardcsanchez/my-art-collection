class Helpers

def self.current_user(session)
   @collector ||= Collector.find_by_id(session[:collector_id])
 end

 def self.is_logged_in?(session)
   !!Collector.find_by_id(session[:collector_id])
 end

 def self.show_links(session)
   if !!Collector.find_by_id(session[:collector_id])
      "<form action= '/collector' method='get'>
          <input  type='submit' value='Your Homepage' />  </form>
        <form action= '/artworks' method='get'>
            <input  type='submit' value='All Artworks' />
          </form>
          <form action= '/artists' method='get'>
              <input  type='submit' value='All Artists' />
            </form>
        <form action= '/genres' method='get'>
            <input  type='submit' value='All Genres' />
          </form>
      <form action= '/logout' method='get'>
      		<input  type='submit' value='Logout' />
      	</form>"
    end
 end



 end
