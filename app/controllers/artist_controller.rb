class ArtistController <ApplicationController

get '/artists' do
  redirect_if_not_logged_in

  @collector = Helpers.current_user(session)
  artists = @collector.artworks.collect {|artwork| artwork.artist}.uniq
  @sorted_artists = artists.sort_by {|a| a.name}

  erb :'artists/artists'
end

get '/artists/master' do
  redirect_if_not_logged_in

  @artists = Artist.all.sort_by {|a| a.name}
  erb :'artists/artist_master'
end

get '/artists/:id' do
  redirect_if_not_logged_in

  @artist = Artist.find_by_id(params[:id])
  @collector = Helpers.current_user(session)

  if !@collector.artists.include?(@artist)
    flash[:message] = "Error: Unable to access artist"
    redirect to '/artists'
  end

  erb :'artists/show_artist'
end

delete '/artists/:id/delete' do
  redirect_if_not_logged_in

  @artist = Artist.find_by_id(params[:id])

  if  @artist.artworks == []
    @artist.destroy
      redirect to '/artists/master'
  else
    flash[:message] = "Error: Artist cannot be deleted at this time.
    Delete or edit all associated artworks first."
    redirect to "/artists/master"
  end
end

get '/artists/:id/edit' do
     redirect_if_not_logged_in

     @artist = Artist.find_by_id(params[:id])
     @collector = Helpers.current_user(session)

     if !@collector.artists.include?(@artist)
       flash[:message] = "Error: Unable to access artist"
       redirect to '/artists'
     end

   erb :'artists/edit_artist'
 end

 patch '/artists/:id' do
   redirect_if_not_logged_in

    @artist = Artist.find_by_id(params[:id])
    @collector = Helpers.current_user(session)

    if !@collector.artists.include?(@artist)
      flash[:message] = "Error: Unable to access artist"
      redirect to '/artists'
    end

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
