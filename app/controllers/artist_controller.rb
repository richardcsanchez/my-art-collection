class ArtistController <ApplicationController

get '/artists' do
  erb :'artists/artists'
end

get '/artists/:id' do
  @artist = Artist.find_by_id(params[:id])
  erb :'artists/show_artist'
end

end
