
require 'deck'
require 'war_player'
require 'game'
require 'card'

describe Deck do
  describe '#build_deck' do
      it 'should have 52 cards when created' do
        deck = Deck.new
        expect(deck.cards_left).to eq 52
      end
      
      it 'checks to see if the deck was built correctly' do
        deck = Deck.new
        expect(deck.cards.first).to eq Card.new('2', 'C')
        expect(deck.cards.last).to eq Card.new('A', 'S')
      end
      
    it 'should have the two of clubs on top' do
      deck = Deck.new
      top_card = deck.cards.first
      expect(top_card).to eq Card.new('2', 'C')
    end

    it 'should be able to shuffle itself' do
      deck = Deck.new 
      expect(deck.cards).to receive(:shuffle!).and_call_original
      
      deck.shuffle!
    end
  end
end