require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
   set :public_folder, 'public'
   set :views, 'app/views'
   enable :sessions
   set :session_secret, "password_security"
 end

  get '/' do
    if Helpers.is_logged_in?(session)
      collector = Helpers.current_user(session)
      redirect to "/collectors/#{collector.slug}"
    end
    
    erb :index
  end


end
