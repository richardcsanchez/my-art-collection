require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
   set :public_folder, 'public'
   set :views, 'app/views'
   enable :sessions
     use Rack::Flash
   set :session_secret, "password_security"
 end

  get '/' do

    erb :index
  end

  helpers do
    def redirect_if_not_logged_in
        if !Helpers.current_user(session)
          flash[:message] = "please log in"
          redirect to '/'
        end
    end
  end


end
