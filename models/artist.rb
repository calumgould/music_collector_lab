require('pg')
require_relative('../db/sql_runner')

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @name = options['name']
  end


  def save()
    sql = "INSERT INTO artists(
    name
    ) VALUES (
      $1
      ) RETURNING id"
      values = [@name]
      results = SqlRunner.run(sql, values)
      @id = results[0]['id'].to_i()
  end

  def update()
    sql = "
    UPDATE artists SET
    name = $1
    WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql="DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end
  def self.delete_all()
    sql="DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM artists"
    names = SqlRunner.run(sql)
    return names.map { |name| Artist.new(name) }
  end

  def self.find_artist(id)
    sql = "SELECT * FROM artists
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    artist_hash = results.first
    artist = Album.new(artist_hash)
    return artist.name
  end




end
