# frozen_string_literal: true 

class Deck
  attr_reader :cards
  def initialize(cards = build_deck)
    @cards = cards
  end

  def cards_left
    cards.length
  end
  
  def shuffle!
    cards.shuffle!
  end

  def deal
  end

  private

  def build_deck
    Card::RANKS.flat_map do |rank|
      Card::SUITS.map do |suit|
        card = Card.new(rank, suit)
      end
    end
  end
end