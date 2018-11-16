class ArtworkController <ApplicationController

  get '/artworks' do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end

    @artworks = Artwork.all.sort_by {|a| a.artist.name}

    erb :'artworks/artwork'
  end

  get '/artworks/new' do
    if !Helpers.is_logged_in?(session)
      redirect to "/login"
    end

    erb :'artworks/create_artwork'
  end

  get '/artworks/:id' do
    if !Helpers.is_logged_in?(session)
      redirect to "/login"
    end

    @artwork = Artwork.find_by_id(params[:id])
    @collector = Helpers.current_user(session)

    if !@collector.artworks.include?(@artwork)
      redirect to '/artworks'
    end


    erb :'artworks/show_artwork'
  end

  get '/artworks/:id/edit' do
    if Helpers.is_logged_in?(session)
        @artwork = Artwork.find_by_id(params[:id])
        @artists = Artist.all
        @genres = Genre.all
     else
       redirect to '/login'
     end

     @collector = Helpers.current_user(session)
     if !@collector.artworks.include?(@artwork)
       redirect to '/artworks'
     end

     erb :'artworks/edit_artwork'
  end

  post '/artworks' do
    @artwork = Artwork.new(params[:artwork])
    if !params["artist"]["name"].empty?
      @artwork.artist = Artist.create(params[:artist])
    elsif params["artist"]["name"].empty?
      @artist = Artist.find_by_id(params[:artwork][:artist_id])
      @artwork.artist_id = @artist.id
    end

    if !params["genre"]["name"].empty?
      @genre = Genre.create(params["genre"])
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

    if !params["artist"]["name"].empty?
      @artwork.artist = Artist.create(params[:artist])
    end

    if !params["genre"]["name"].empty?
      genre = Genre.create(params[:genre])
      @artwork.genre_id = genre.id
     end

    @artwork.update(params[:artwork])
    redirect to "artworks/#{@artwork.id}"
    end

end
