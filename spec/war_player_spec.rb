# frozen_string_literal: true

require 'pry'
require 'card'
require 'war_player'

describe WarPlayer do
  describe 'basic funtions of creation' do
    it 'initializes without error' do
      expect { WarPlayer.new([Card.new('J', 'D'), Card.new('A', 'H')]) }.not_to raise_error
    end
    
    it 'defaults cards to empty list if none are provided' do
      player = WarPlayer.new
      expect(player.cards).to eq []
    end
    
    it 'has a list of cards' do
      cards = [Card.new('J', 'D'), Card.new('A', 'H')]
      player = WarPlayer.new(cards)
      expect(player.cards).to eq cards
    end
  end

  describe '#play' do
    it 'expects a player to put out their first card' do
    end
  end

  describe '#take' do
    it 'adds the provided card to the hand' do
      cards = [Card.new('Q', 'D'), Card.new('7', 'S'), Card.new('9', 'C')]
      player = WarPlayer.new([cards[0], cards[1]])
      player.take(cards[2])
      expect(player.cards).to eq [cards[0], cards[1]]
      expect(player.winnings).to eq [cards[2]]
    end
    
    it 'takes multiple cards' do
      cards = [Card.new('Q', 'D'), Card.new('7', 'S'), Card.new('9', 'C')]
      player = WarPlayer.new
      player.take(cards)
      
      expect(player.winnings).to match_array cards
    end
    
    it 'adds cards to winnings' do
      player = WarPlayer.new
      card = Card.new('5', 'C')
      player.take(card)
      expect(player.cards).to be_empty
      expect(player.winnings).to eq([card])
    end
  end
end
