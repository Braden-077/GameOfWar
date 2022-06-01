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

  describe '#has_cards?' do
    it 'returns true when cards are present' do
      player = WarPlayer.new([Card.new('A', 'H')])
      expect(player.has_cards?).to be true
    end

    it 'returns true when winnings are present' do
      player = WarPlayer.new
      player.take(Card.new('A', 'S'))
      expect(player.has_cards?).to be true
    end

    it 'returns false when cards are NOT present' do
      player = WarPlayer.new([])
      expect(player.has_cards?).to be false
    end
  end

  describe '#play' do
    it 'returns the first card from hand and removes it' do
      cards = [Card.new('Q', 'D'), Card.new('7', 'S'), Card.new('9', 'C')]
      player = WarPlayer.new(cards)
      expect(player.play).not_to eq cards[0]
      expect(player.cards).to eq cards
    end

    it 'can play multiple cards at a time' do
      cards = [Card.new('Q', 'D'), Card.new('7', 'S'), Card.new('9', 'C')]
      player = WarPlayer.new(cards)
      expect(player.play(2).count).to eq 2
    end

    it 'gets a new player without cards' do
      player = WarPlayer.new([])
      card = Card.new('A', 'S')
      player.take(card)
      expect(player.play).to eq Card.new('A', 'S')
    end
  end

  describe '#take' do
    it 'adds the provided card to the hand' do
      first_card = Card.new('Q', 'D')
      second_card = Card.new('7', 'S')
      third_card = Card.new('9', 'C')
      player = WarPlayer.new([first_card, second_card])

      player.take(third_card)

      expect(player.cards).to match_array [first_card, second_card]
      expect(player.winnings).to match_array [third_card]
    end
    
    it 'takes multiple cards' do
      first_card = Card.new('Q', 'D')
      second_card = Card.new('7', 'S')
      third_card = Card.new('9', 'C')
      player = WarPlayer.new
      
      player.take([first_card, second_card, third_card])
      
      expect(player.winnings).to match_array [first_card, second_card, third_card]
    end
    
    it 'adds cards to winnings' do
      player = WarPlayer.new
      card = Card.new('5', 'C')

      player.take(card)
      
      expect(player.cards).to be_empty
      expect(player.winnings).to eq([card])
    end
    it 'adds the provided card to the hand' do
      first_card = Card.new('Q', 'D')
      second_card = Card.new('7', 'S')
      third_card = Card.new('9', 'C')
      player = WarPlayer.new([first_card, second_card])
      
      player.take(third_card)
      
      expect(player.cards).to match_array [first_card, second_card]
      expect(player.winnings).to match_array [third_card]
    end
    
    it 'takes multiple cards' do
      first_card = Card.new('Q', 'D')
      second_card = Card.new('7', 'S')
      third_card = Card.new('9', 'C')
      player = WarPlayer.new
      
      player.take([first_card, second_card, third_card])
      
      expect(player.winnings).to match_array [first_card, second_card, third_card]
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
