class GenreController <ApplicationController

  get '/genres' do
    redirect_if_not_logged_in


    @collector = Helpers.current_user(session)
    @genres = @collector.artworks.collect {|artwork| artwork.genre}.uniq
    @sorted_genres = @genres.sort_by {|g| g.name}


    erb :'genres/genres'
  end

  get '/genres/master' do
    redirect_if_not_logged_in

    @genres = Genre.all.sort_by {|g| g.name}
    erb :'genres/genre_master'
  end

  get '/genres/:id' do
    redirect_if_not_logged_in


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

    if  @genre.artworks == []
      @genre.destroy
        redirect to '/genres/master'
    else
      flash[:message] =
        "Error: Genre cannot be deleted at this time.
        Delete or edit all associated artworks first."
      redirect to "/genres/master"
    end
  end

end
