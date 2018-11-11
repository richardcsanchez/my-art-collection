genre_list = {
  "Sculpture": {
  },
  "New Media": {
  },
  "Painting": {
  },
  "Photography": {
  },
  "Mixed Media": {
  },
  "Installation": {
  },
  "Drawing": {
  }
}

genre_list.each do |genre, artwork_hash|
  p = Genre.new
  p.name = genre
  p.save
end
