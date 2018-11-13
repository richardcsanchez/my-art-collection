class ArtworkController <ApplicationController

  get '/artworks' do
    erb :'artworks/artwork'
  end

  get '/artworks/new'do
    erb :'artworks/create_artwork'
  end

  post '/artworks' do
    @artwork = Artwork.new(params[:artwork])
    if !params["artist"]["name"].empty?
      @artwork.artist = Artist.new(params[:artist])
    else params["artist"]["name"].empty?
      @artwork.artist = Artist.find_by(params[:artwork][:artist])
    end
    @artwork.genre = Genre.find_by(params[:artwork][:genre])
    @artwork.collector = Helpers.current_user(session)
    @artwork.save

    redirect to "/artworks"
  end

  get '/artwork/:id/delete' do
    binding.pry
    @artwork = Artwork.find(params[:id])
    if @artwork.collector != Helpers.current_user(session)
      redirect to '/artworks'
    end
    if Helpers.is_logged_in?(session)
        @artwork.destroy
        redirect to '/artworks'
      else
        redirect to '/artworks'
      end
      redirect to '/login'
  end


end
