# frozen_string_literal: true

require_relative 'deck'
require_relative 'war_player'
require 'pry'

class Game
  attr_reader :players, :deck
  def initialize(players=[WarPlayer.new, WarPlayer.new], deck = Deck.new)
    @players = players
    @deck = deck
  end

  def start 
    deck.shuffle!
    until deck.cards_left == 0
      players.each do |player|
        player.cards.push(deck.deal)
      end
    end
  end

  def play_round
    tied_winnings = []
    compare_round_cards(tied_winnings)
  end

  def winner
    players.delete_if {|player| player.cards.length == 0} 
    players.length == 1 ? (players.first) : nil 
  end

  def compare_round_cards(tied_winnings)
    card1 = players.first.play
    card2 = players.last.play
    if card1.nil?
      players.last.take([card1, card2])
      tied_winnings.each { |card| players.last.take(card) }
    elsif card2.nil?
      players.first.take([card2, card1])
      tied_winnings.each { |card| players.first.take(card) }
    elsif card1.value > card2.value
      players.first.take([card2, card1])
      tied_winnings.each { |card| players.first.take(card) }
    elsif card1.value < card2.value
      players.last.take([card1, card2])
      tied_winnings.each { |card| players.last.take(card) }
    else 
      tied_winnings = Array(tied_winnings).push([card1, card2])
      compare_round_cards(tied_winnings)
    end
  end
end
