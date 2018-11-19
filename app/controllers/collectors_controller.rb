class CollectorsController <ApplicationController

  get '/signup' do
    if Helpers.is_logged_in?(session)
      collector = Helpers.current_user(session)
      redirect to "/collectors/#{collector.slug}"
    end

    erb :'collectors/create_collector'
  end

  post '/signup' do
    if !(params.has_value?("")) && (params[:email].include?("@"))
      @collector = Collector.create(username: params[:username], email: params[:email], password: params[:password])
      session["collector_id"] = @collector.id
      redirect to "/collectors/#{@collector.slug}"
    else
      flash[:message] = "Sign-up failed. Please try again."
      redirect to '/signup'
    end
  end

  get '/collectors/:slug' do
    if Helpers.is_logged_in?(session)
      @collector = Collector.find_by_slug(params[:slug])
    else
      redirect to '/login'
    end

    erb :'/collectors/show'
  end

  get "/logout" do
    if Helpers.is_logged_in?(session)
      session.clear
    else
      redirect to "/"
    end

    redirect to '/'
  end

end
