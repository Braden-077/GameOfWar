# frozen_string_literal: true

require_relative 'deck'
require_relative 'war_player'
require 'pry'

class Game
  attr_reader :players, :deck
  def initialize(players=[], deck = [])
    @players = players
    @deck = Deck.new
  end

  def start 
    deck.shuffle!
    until deck.cards_left == 0
      players.each do |player|
        player.cards.push(deck.deal)
      end
    end
  end
end
