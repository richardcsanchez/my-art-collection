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

  get '/collector' do
    @collector = Helpers.current_user(session)
    if !Helpers.is_logged_in?(session)
      flash[:message] = "Please log in to view this page."
      redirect to '/login'
    end
    redirect to "/collectors/#{@collector.slug}"
  end

  get '/collectors/:slug' do
    @collector = Helpers.current_user(session)

    if !Helpers.is_logged_in?(session)
      flash[:message] = "Please log in to view this page."
      redirect to '/login'
    elsif Collector.find_by_slug(params[:slug]) != @collector
      flash[:message] = "You cannot view this user's page"
      redirect to "/collectors/#{@collector.slug}"
    end

    erb :'/collectors/show'
  end

  get '/collectors/:id/edit' do
    if Helpers.is_logged_in?(session)
        @collector = Helpers.current_user(session)
      else

       flash[:message] = "Please log in to view this page."
       redirect to '/login'
     end

     erb :'collectors/edit_collector'
  end

  delete '/collectors/:slug/delete' do
    @collector = Helpers.current_user(session)

    if !Helpers.is_logged_in?(session)
      flash[:message]= "Please login to perform this action"
      redirect to '/login'
    end

    if Collector.find_by_slug(@collector.slug) == Helpers.current_user(session)
      @collector.delete
      flash[:message] = "Profile deleted"
        redirect to '/'
    else
      redirect to "/collectors/#{@collector.slug}"
    end
  end

  patch '/collectors/:id' do
    @collector = Collector.find_by_id(params[:id])
    if !(params.has_value?("")) && (params[:email].include?("@"))
      @collector.update(email: params["email"], username: params["username"], password: params["password"])
    else
      flash[:message] = "Unable to update profile"
    end
    redirect to "collectors/#{@collector.slug}"
    end

end
