class ArtworkController <ApplicationController

  get '/artworks' do
    if !Helpers.is_logged_in?(session)
      redirect to '/'
    erb :'artworks/artwork'
    end

    erb :'artworks/artwork'
  end

  get '/artworks/new' do
    erb :'artworks/create_artwork'
  end

  get '/artworks/:id' do
    @artwork = Artwork.find_by_id(params[:id])
    erb :'artworks/show_artwork'
  end

  get '/artworks/:id/edit' do
    if Helpers.is_logged_in?(session)
        @artwork = Artwork.find_by_id(params[:id])
     else
       redirect to '/login'
     end
     erb :'artworks/edit_artwork'
  end

  post '/artworks' do
    @artwork = Artwork.new(params[:artwork])

    if !params["artist"]["name"].empty?
      @artwork.artist = Artist.new(params[:artist])
    elsif params["artist"]["name"].empty?
      @artist = Artist.find_by_id(params[:artwork][:artist_id])
      @artwork.artist_id = @artist.id
    end

    if !params["genre"]["name"].empty?
      @genre = Genre.new(params[:genre])
      @artwork.genre_id = @genre.id
    elsif params["genre"]["name"].empty?
       @genre = Genre.find_by_id(params[:artwork][:genre_id])
       @artwork.genre_id = @genre.id
     end

    @artwork.collector = Helpers.current_user(session)
    @artwork.save

    redirect to "/artworks"
  end

  delete '/artworks/:id/delete' do
    if Helpers.is_logged_in?(session)
      @artwork = Artwork.find_by_id(params[:id])
    else
      redirect to '/login'
    end
    if @artwork.collector == Helpers.current_user(session)
      @artwork.delete
        redirect to '/artworks'
    else
      redirect to "/artworks/#{@artwork.id}"
    end
  end

  patch '/artworks/:id' do
      @artwork = Artwork.find_by_id(params[:id])
      if @artwork.collector != Helpers.current_user(session)
        redirect to '/login'
      end
        @artwork.update(params[:artwork])
        @artwork.save
      redirect to "/artworks/#{@artwork.id}"
    end

end
