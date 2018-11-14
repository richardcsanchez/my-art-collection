class ArtistController <ApplicationController

get '/artists' do
  erb :'artists/artists'
end

get '/artists/:id' do
  @artist = Artist.find_by_id(params[:id])
  erb :'artists/show_artist'
end

get '/artists/:id/delete' do
  binding.pry

  if Helpers.is_logged_in?(session)
    @artist = Artist.find_by_id(params[:id])
  else
    redirect to '/login'
  end

  if  @artist.artworks == nil
    @artist.delete
      redirect to '/artworks'
  else
    redirect to "/artists"
  end
end

end
