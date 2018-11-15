class ArtistController <ApplicationController

get '/artists' do
  if !Helpers.is_logged_in?(session)
    redirect to '/'
  end

  erb :'artists/artists'
end

get '/artists/:id' do
  @artist = Artist.find_by_id(params[:id])

  @collector = Helpers.current_user(session)
  if !@collector.artists.include?(@artist)
    redirect to '/artists'
  end

  erb :'artists/show_artist'
end

get '/artists/:id/delete' do
  @artist = Artist.find_by_id(params[:id])

  erb :'artists/edit_artist'
end

delete '/artists/:id/delete' do
  if Helpers.is_logged_in?(session)
    @artist = Artist.find_by_id(params[:id])
  else
    redirect to '/login'
  end

  if  @artist.artworks == []
    @artist.destroy
      redirect to '/artists'
  else
    redirect to "/artists"
  end
end

get '/artists/:id/edit' do
     if Helpers.is_logged_in?(session)
       @artist = Artist.find_by_id(params[:id])
     else
       redirect to '/login'
     end

     @collector = Helpers.current_user(session)
     if !@collector.artists.include?(@artist)
       redirect to '/artists'
     end

   erb :'artists/edit_artist'
 end

 patch '/artists/:id' do
    @artist = Artist.find_by_id(params[:id])

    if !(params.has_value?(""))
        @artist.update(name: params["name"], bio: params["bio"], associated_movements: params["associated_movements"])
        @artist.save
      else
        redirect to "/artists/#{@artist.id}/edit"
    end

    redirect to "/artists/#{@artist.id}"
  end

end
