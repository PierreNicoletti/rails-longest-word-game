require 'open-uri'

class GamesController < ApplicationController
  ALPHABET = ("A".."Z").to_a

  def new
    @letters = []
    10.times { @letters << ALPHABET[rand(0..25)] }
  end

  def score
    @is_built_from_grid = true
    @word = params[:word]
    @letters = params[:letters].split(" ")
    @word.upcase!.split("").each do |letter|
      @is_built_from_grid &&= @letters.include?(letter)
    end

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_serialized = open(url).read
    result = JSON.parse(word_serialized)
    @is_valid = result["found"]
  end
end
