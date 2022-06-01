# frozen_string_literal: true 

class Card
  SUITS = ['C', 'H', 'D', 'S']
  RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def suit
    SUITS.include?(@suit) ? @suit : 'This is not a valid suit.'
  end

  def rank
    RANKS.include?(@rank) ? @rank : 'This is not a valid rank.'
  end

  def value
    RANKS.index(rank)
  end

  def ==(other)
    @suit == other.suit && @rank == other.rank
  end
end 
