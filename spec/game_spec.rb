# frozen_string_literal: true

require 'card'
require 'war_player'
require 'game'
require 'pry'

describe Game do
    let(:player1) do
      WarPlayer.new
    end

    let(:player2) do
      WarPlayer.new
    end
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
    
    it 'should not default players to empty list if none are provided' do
      game = Game.new
      expect(game.players).not_to eq []
    end
    
    it 'has a list of players' do
      game = Game.new(players)
      expect(game.players).to eq players
    end

  end
  describe '#start' do
    it 'deals all the cards when the game is started' do
      game = Game.new([player1, player2])
      game.start
      expect(game.deck.cards_left).to be_zero
      expect(game.players[0].cards.length).to eq 26
      expect(game.players[1].cards.length).to eq 26
    end
  end
  describe '#play_round' do
    it 'makes sure players don\'t have the same amount of cards as when dealt' do
      game = Game.new([WarPlayer.new([Card.new('K', 'S')], 'Josh'), WarPlayer.new([Card.new('A', 'S')], 'Braden')])
      game.play_round
      expect(game.winner.name).to eq 'Braden'
      expect(game.players.first.cards.length).to eq 2
    end
  end
  describe '#winner' do 
    it 'gives us the expected winner\'s name back' do
      game = Game.new([WarPlayer.new([Card.new('K', 'S')], 'Josh'), WarPlayer.new([Card.new('A', 'S')], 'Braden')])
      game.play_round
      expect(game.winner.name).to eq 'Braden'
    end

    it 'give\'s the round winner\'s name as expected' do
      game = Game.new([WarPlayer.new([Card.new('A', 'S')], 'Jeremy'), WarPlayer.new([Card.new('K', 'S')], 'Ken')])
      jeremy = game.players.first
      ken = game.players.last
      expect(game.round_message(jeremy.name, jeremy.cards[0].rank, ken.name, ken.cards[0].rank)).to eq 'Jeremy played A and beat Ken who played K.'
      game.play_round
    end 
  end
end  
