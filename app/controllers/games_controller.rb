require 'open-uri'
require 'json'

class GamesController < ApplicationController
    def new
        @letters = []
        20.times { |_i| @letters << ('A'..'Z').to_a.sample }
        @time = Time.now.to_f
    end

    def letter_in_grid
        @answer.upcase.chars.sort.all? { |letter| @letters.include?(letter) }
    end
    
    def score
        @letters = params[:letters]
        @answer = params[:word]
        url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
        word_dictionary = open(url).read
        word = JSON.parse(word_dictionary)
        word = word[:found]
        # raise
        if !letter_in_grid
            @result = "Sorry, but #{@answer.upcase} can’t be built out of #{@letters}."
        elsif !word
            @result = "Sorry but #{@answer.upcase} does not seem to be an English word."
        elsif letter_in_grid && !word
            @result = "Sorry but #{@answer.upcase} does not seem to be an English word."
        elsif letter_in_grid && word == true
            @result = "Congratulation! #{@answer.upcase} is a valid English word."
        end
    end
end
