class ArtworkController <ApplicationController

  get '/artworks' do
    if !Helpers.is_logged_in?(session)
      redirect to '/'
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

  post '/artworks' do
    @artwork = Artwork.new(params[:artwork])
    if !params["artist"]["name"].empty?
      @artwork.artist = Artist.new(params[:artist])
    elsif params["artist"]["name"].empty?
      @artwork.artist = Artist.find_by(params[:artwork][:artist])
    end
    if !params["genre"]["name"].empty?
      @artwork.genre = Genre.new(params["genre"])
    elsif params["genre"]["name"].empty?
       @artwork.genre = Genre.find_by(params[:artwork][:genre])
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


end
