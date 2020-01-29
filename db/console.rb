require("pry")
require_relative('../models/album')
require_relative('../models/artist')
#
# Artist.delete_all()
# Album.delete_all()

artist1 = Artist.new({
  'name' => 'RHCP'
  })
artist1.save()

album1 = Album.new({
  'name' => 'Californication',
  'genre' => 'Rock',
  'artist_id' => artist1.id
  })
album1.save()



binding.pry
nil
