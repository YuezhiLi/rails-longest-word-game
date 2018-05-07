require 'open-uri'
class GamesController < ApplicationController

  def new
    n = (1..26).to_a.sample
    @letters = ("A".."Z").to_a.sample(n)
  end

  def score
    @letters = params[:letters]
    @word = params[:word]
    if (@word.upcase.split("").uniq - @letters.split(" ")).empty? == false
      @result = "Sorry but #{@word.upcase} cannot be built out of #{@letters}"
    elsif english_word?(@word) == false
      @result = "Sorry but #{@word.upcase} does not seem to be a valid English word..."
    else
      @result = "Congratulations! #{@word.upcase} is a valid English word!"
    end
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    r = JSON.parse(open(url).read)
    r["found"]
  end
end
