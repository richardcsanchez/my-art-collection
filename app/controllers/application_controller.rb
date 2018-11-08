require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
   set :public_folder, 'public'
   set :views, 'app/views'
   enable :sessions
   set :session_secret, "password_security"
 end

  get '/' do
    erb :index
  end

  helpers do
  		def logged_in?
  			!!session[:collector_id]
  		end

   		def current_user
  			User.find_by(session[:collector_id])
  		end

      def show_logout
         if !!Collector.find_by_id(session[:collector_id])
            "  <form action= '/logout' method='get'>
            		<input type='submit' value='Logout' />
            	</form>"
         elsif !Collector.find_by_id(session[:collector_id])
            nil
         end
       end

  	end

end
