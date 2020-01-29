require('pg')
require_relative('../db/sql_runner')

class Album

attr_reader :id, :artist_id
attr_accessor :name, :genre

  def initialize(options)
    @name = options['name']
    @genre = options['genre']
    @id = options['id'].to_i() if options['id']
    @artist_id = options['artist_id'].to_i()
  end

  def save()
    sql = "INSERT INTO albums(
    name,
    genre,
    artist_id
    ) VALUES (
      $1, $2, $3
      ) RETURNING id"
      values = [@name, @genre, @artist_id]
      results = SqlRunner.run(sql, values)
      @id = results[0]['id'].to_i()
  end

  def update()
    sql = "
    UPDATE albums SET
    (
      name,
      genre,
      artist_id
    ) =
    (
      $1, $2, $3
    )
    WHERE id = $4"
    values = [@name, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def find_artist()
    sql = "SELECT * FROM artists
    WHERE id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    artist_hash = results.first
    artist = Artist.new(artist_hash)
    return artist.name
  end

    def delete()
      sql="DELETE FROM albums WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end

    def self.delete_all()
      sql="DELETE FROM albums"
      SqlRunner.run(sql)
    end

  def self.all()
    sql = "SELECT * FROM albums"
    names = SqlRunner.run(sql)
    return names.map { |name| Album.new(name)}
  end

  def self.find_all(artist_id)
    sql = "SELECT * FROM albums
    WHERE artist_id = $1"
    values = [artist_id]
    results = SqlRunner.run(sql, values)
    album_hash = results.first
    album = Album.new(album_hash)
    return album
  end




end
