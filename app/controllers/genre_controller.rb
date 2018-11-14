class GenreController <ApplicationController

  get '/genres' do
    erb :'genres/genres'
  end

  get '/genres/:id' do
    @genre = Genre.find_by_id(params[:id])
    erb :'genres/show_genre'
  end

  get '/genres/:id/delete' do
    @genre = Genre.find_by_id(params[:id])
    @genre.destroy
    redirect to "/genres"
  end

end
