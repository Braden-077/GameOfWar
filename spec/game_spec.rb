# frozen_string_literal: true

require 'card'
require 'war_player'
require 'game'

describe Game do
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
