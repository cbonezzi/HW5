class Movie < ActiveRecord::Base
  
  def self.all_ratings
    %w(G PG PG-13 R)
  end
  
  class Movie::InvalidKeyError < StandardError ; end
  
  def self.api_key
    'f4702b08c0ac6ea5b51425788bb26562'
  end

  def self.default_language
    'en'
  end

  def self.find_in_tmdb(string)
    
    movies_collected = Array.new
    Tmdb::Api.key(self.api_key)
    Tmdb::Api.language(self.default_language)
    matching_movies = Tmdb::Movie.find(string)
    matching_movies.each do |movie|
      movies_hash = Hash.new
      movies_hash[:tmdb_id] = movie.id
      movies_hash[:title] = movie.title
      movies_hash[:rating] ='PG'
      movies_hash[:release_date] = movie.release_date
      movies_collected.push(movies_hash)
    end
    movies_collected
  end
end
