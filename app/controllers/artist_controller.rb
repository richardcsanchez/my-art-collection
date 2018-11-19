class ArtistController <ApplicationController

get '/artists' do
  if !Helpers.is_logged_in?(session)
    flash[:message] = "Please log in to view this page."
    redirect to '/'
  end

  @collector = Helpers.current_user(session)
  artists = @collector.artworks.collect {|artwork| artwork.artist}.uniq
  @sorted_artists = artists.sort_by {|a| a.name}

  erb :'artists/artists'
end

get '/artists/master' do
  if !Helpers.is_logged_in?(session)
    flash[:message] = "Please log in to view this page."
    redirect to '/'
  end
  erb :'artists/artist_master'
end

get '/artists/:id' do
  if !Helpers.is_logged_in?(session)
    flash[:message] = "Please log in to view this page."
    redirect to "/login"
  end

  @artist = Artist.find_by_id(params[:id])
  @collector = Helpers.current_user(session)

  if !@collector.artists.include?(@artist)
    flash[:message] = "Error: Unable to access artist"
    redirect to '/artists'
  end

  erb :'artists/show_artist'
end

delete '/artists/:id/delete' do
  if Helpers.is_logged_in?(session)
    @artist = Artist.find_by_id(params[:id])
  else
    redirect to '/login'
  end

  @collector = Helpers.current_user(session)
  if !@collector.artists.include?(@artist)
    flash[:message] = "Error: Unable to access artist"
    redirect to '/artists'
  end

  if  @artist.artworks == []
    @artist.destroy
      redirect to '/artists'
  else
    flash[:message] = "Error: Artist cannot be deleted at this time.
    Delete or edit all associated artworks first."
    redirect to "/artists"
  end
end

get '/artists/:id/edit' do
     if Helpers.is_logged_in?(session)
       @artist = Artist.find_by_id(params[:id])
     else
       flash[:message] = "Please log in to view this page."
       redirect to '/login'
     end

     @collector = Helpers.current_user(session)
     if !@collector.artists.include?(@artist)
       flash[:message] = "Error: Unable to access artist"
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
        flash[:message] = "Error: Unable to update artist"
        redirect to "/artists/#{@artist.id}/edit"
    end

    redirect to "/artists/#{@artist.id}"
  end

end
