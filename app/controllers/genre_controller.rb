class GenreController <ApplicationController

  get '/genres' do
    erb :'genres/genres'
  end

  get '/genres/:id' do
    @genre = Genre.find_by_id(params[:id])
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
        redirect to '/genres'
    else
      redirect to "/genres"
    end
  end

end
