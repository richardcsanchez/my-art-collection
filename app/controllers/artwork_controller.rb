class ArtworkController <ApplicationController

  get '/artworks' do
    erb :'artworks/artworks'
  end

  get '/artworks/new'do
    erb :'artworks/create_artwork'
  end

  post '/artworks' do
    @artwork = Artwork.new(params[:artwork])
    if !params["artist"]["name"].empty?
      binding.pry
      @artwork.artists << Artist.new(params[:artist])
    end
    @artwork.save

    redirect to "/artworks"
  end


end
