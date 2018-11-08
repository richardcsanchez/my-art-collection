class CollectorsController <ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/my-collection'
    end
    erb :'collectors/create_collector'
  end

  post '/signup' do
    if !(params.has_value?("")) && (params[:email].include?("@"))
      @collector = Collector.create(username: params[:username], email: params[:email], password: params[:password])
      session["collector_id"] = @collector.id
      redirect to '/my-collection'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/my-collection'
    end
    erb :'collectors/login'
  end

  post '/login' do
    @collector = Collector.find_by(:username => params[:username])
    if @collector && @collector.authenticate(params[:password])
      session["collector_id"] = @collector.id
      redirect to '/my-collection'
    else
      redirect to "/login"
    end
  end

  get '/my-collection' do
    if logged_in?
      @collector = Collector.find_by(params[:username])
    else
      redirect to '/login'
    end
    erb :'/collectors/show'
  end

  get "/logout" do
    if logged_in?
      session.clear
    else
      redirect to "/"
    end
    redirect to '/'
  end

end
