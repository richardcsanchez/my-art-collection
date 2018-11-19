class GenreController <ApplicationController

  get '/genres' do
    if !Helpers.is_logged_in?(session)
      flash[:message] = "Please log in to view this page."
      redirect to "/login"
    end

    @collector = Helpers.current_user(session)
    @genres = @collector.artworks.collect {|artwork| artwork.genre}.uniq
    @sorted_genres = @genres.sort_by {|g| g.name}


    erb :'genres/genres'
  end

  get '/genres/:id' do
    if !Helpers.is_logged_in?(session)
      flash[:message] = "Please log in to view this page."
      redirect to "/login"
    end

    @genre = Genre.find_by_id(params[:id])
    @collector = Helpers.current_user(session)

    if !@collector.genres.include?(@genre)
      flash[:message] = "Error: Unable to access genre"
      redirect to '/genres'
    end

    erb :'genres/show_genre'
  end

  delete '/genres/:id/delete' do
    if Helpers.is_logged_in?(session)
      @genre = Genre.find_by_id(params[:id])
    else
      redirect to '/login'
    end

    @collector = Helpers.current_user(session)
    if !@collector.genres.include?(@genre)
      flash[:message] = "Error: Unable to access genre"
      redirect to '/genres'
    end

    if  @genre.artworks == []
      @genre.destroy
        redirect to '/genres'
    else
      flash[:message] = 
        "Error: Genre cannot be deleted at this time.
        Delete or edit all associated artworks first."
      redirect to "/genres"
    end
  end

end
