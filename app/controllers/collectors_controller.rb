class CollectorsController <ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/show'
    end
    erb :'collectors/create_collector'
  end

  post '/signup' do
    if !(params.has_value?("")) && (params[:email].include?("@"))
      @collector = Collector.create(username: params[:username], email: params[:email], password: params[:password])
      session["collector_id"] = @collector.id
      redirect to '/show'
    else
      redirect to '/signup'
    end
  end

end
