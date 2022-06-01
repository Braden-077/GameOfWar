# frozen_string_literal: true

require 'card'
require 'war_player'

describe WarPlayer do
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
      first_card = Card.new('Q', 'D')
      second_card = Card.new('7', 'S')
      third_card = Card.new('9', 'C')

      player = WarPlayer.new([first_card, second_card, third_card])

      expect(player.play).to eq first_card
      expect(player.cards).to match_array [second_card, third_card]
    end

    it 'can play multiple cards at a time' do
      first_card = Card.new('Q', 'D')
      second_card = Card.new('7', 'S')
      third_card = Card.new('9', 'C')

      player = WarPlayer.new([first_card, second_card, third_card])
      expect(player.play(2).count).to eq 2
    end

    it 'plays different cards every time' do
      first_card = Card.new('A', 'S')
      second_card = Card.new('Q', 'H'), 
      third_card = Card.new('K', 'D')

      player = WarPlayer.new([first_card, second_card, third_card])

      card1 = player.play
      player.take(card1)
      card2 = player.play
      
      expect(card1).not_to eq card2
      expect(card1).to eq first_card
      expect(card2).to eq second_card
    end

    it 'gets a new player without cards' do
      player = WarPlayer.new([])
      card = Card.new('A', 'S')
      player.take(card)
      expect(player.play).to eq card
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
  end

  describe '#take_into_hand' do
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
