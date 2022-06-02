# frozen_string_literal: true

require 'card'
require 'war_player'
require 'game'
require 'pry'

describe Game do
  describe '#initialize' do
    subject(:game) { Game.new(players) }
    let(:players) do
      [
        WarPlayer.new([]),
        WarPlayer.new([])
      ]
    end
    
    it 'initializes without error' do
      expect { Game.new(players) }.not_to raise_error
    end
    
    it 'defaults players to empty list if none are provided' do
      game = Game.new
      expect(game.players).to eq []
    end
    
    it 'has a list of players' do
      game = Game.new(players)
      expect(game.players).to eq players
    end

  end
  describe '#start' do
    it 'deals all the cards when the game is started' do
      game = Game.new([WarPlayer.new, WarPlayer.new])
      game.start
      expect(game.deck.cards_left).to eq 0
      expect(game.players[0].cards.length).to eq 26
      expect(game.players[1].cards.length).to eq 26
    end
  end
end  
