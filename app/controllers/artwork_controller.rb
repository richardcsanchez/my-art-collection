class ArtworkController <ApplicationController

  get '/artworks/new'do
    erb :'artworks/create_artwork'
  end
end
