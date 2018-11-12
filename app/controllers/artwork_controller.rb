class ArtworkController <ApplicationController

  get '/artworks' do
    erb :'artworks/artwork'
  end

  get '/artworks/new'do
    erb :'artworks/create_artwork'
  end

  post '/artworks' do
    binding.pry

    @artwork = Artwork.new(params[:artwork])
    if !params["artist"]["name"].empty?
      @artwork.artist = Artist.new(params[:artist])
    else
      @artwork.artist = Artist.find_by(params[:artwork][:artist])
    end
    if !params[:genre][:name].empty?
      @artwork.genre = Genre.new(params[:genre])
    else
      @artwork.genre = Genre.find_by(params[:artwork][:genre])
    end
    @artwork.collector = Helpers.current_user(session)
    @artwork.save

    redirect to "/artworks"
  end


end
