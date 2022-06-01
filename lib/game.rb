# frozen_string_literal: true

require_relative 'deck'

class Game
  attr_reader :players
  def initialize(players=[])
    @players = players
  end

  def deal
    deck = Deck.new
    deck.shuffle!
    until deck.empty?
      deck.deal
    end
  end

  def play_war_round(players)
    # card1 = players.first.play
    # card2 = players.last.play
    # if !card1
    #   players.last.take(card2)
    #   players.last
    # elsif !card2
    #   players.first.take(card1)
    #   players.first
    # elsif card1.value > card2.value
    #   players.first.take([card1, card2])
    #   players.first
    # elsif card1.value < card2.value 
    #   players.last.take([card1, card2])
    #   players.last
    # elsif card1.value == card2.value
    #   extra_cards = players.first.play(3) + players.last.play(3)
    #   winner = play_war_round
    #   winner.take([card1, card2])
    #   winner.take(extra_cards)
    #   winner
    # end
  end
end
