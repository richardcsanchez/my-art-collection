class CreateArtworks < ActiveRecord::Migration
  def change
    create_table :artworks do |t|
    t.string :title
    t.integer :year
    t.string :materials
    t.integer :collector_id
    t.integer :artist_id
    t.integer :genre_id
  end
  end
end
