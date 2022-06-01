# frozen_string_literal: true 
class WarPlayer
  
  
  attr_reader :cards, :name, :winnings
  def initialize(cards = [])
    @name = ['Andrew', 'William', 'Josh', 'Braden', 'Caleb', 'Jeremy'].sample
    @cards = cards
    @winnings = []
  end
  
  def name
    @name
  end

  def has_cards?
    !cards.empty? || !winnings.empty?
  end

  def take(new_cards)
    if new_cards.kind_of?(Array)
      winnings.push(*new_cards.compact)
    elsif new_cards
      winnings.push(new_cards)
    end
  end

  def play
    
  end
end 