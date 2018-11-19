class SessionsController <ApplicationController

get '/login' do
    if Helpers.is_logged_in?(session)
      collector = Helpers.current_user(session)
      redirect to "/collectors/#{collector.slug}"
    end
     erb :'collectors/login'
  end

   post '/login' do
    @collector = Collector.find_by(username: params[:username])
     if @collector && @collector.authenticate(params[:password])
      session[:collector_id] = @collector.id
      redirect to "/collectors/#{@collector.slug}"
    else
      flash[:message] = "Unable to login"
      redirect to '/login'
    end
   end

   get "/logout" do
     if Helpers.is_logged_in?(session)
       session.clear
     end
     flash[:message] = "You've logged out"
     redirect to '/'
   end
   
 end
