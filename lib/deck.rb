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

  def deal(players=[], num_cards=nil)
    return if players.empty?
    
      cards.shift(num_cards || cards.count).each.with_index do |card, index|
       players[index % players.count].take_into_hand(card)
      end
    end
  end

  private

  def build_deck
    Card::SUITS.flat_map do |suit|
      Card::RANKS.map do |rank|
        card = Card.new(suit, rank)
    end
  end
end