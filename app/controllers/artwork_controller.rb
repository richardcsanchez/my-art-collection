class ArtworkController <ApplicationController

  get '/artworks' do
    erb :artworks
  end
  
  get '/artworks/new'do
    erb :'artworks/create_artwork'
  end

  post '/artworks'
end
