# frozen_string_literal: true

require 'card'
require 'war_player'
require 'game'

describe Game do
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

  describe '#deal' do
    subject(:game) { Game.new(players) }

    it 'shuffles and distributes equal number cards to each player' do
      expect(players.first.cards.count).to eq 0
      expect(players.last.cards.count).to eq 0
      game.deal

      expect(players.first.cards.count).to eq 26
      expect(players.last.cards.count).to eq 26
    end

    context 'with 3 players' do
      let(:players) do
        [
          WarPlayer.new([]),
          WarPlayer.new([]),
          WarPlayer.new([])
        ]
      end

      it 'shuffles and distributes equal number cards to each player' do
        expect(players[0].cards.count).to eq 0
        expect(players[1].cards.count).to eq 0
        expect(players[2].cards.count).to eq 0
        game.deal

        expect(players[0].cards.count).to eq 18
        expect(players[1].cards.count).to eq 17
        expect(players[2].cards.count).to eq 17
      end
    end

    context 'with 4 players' do
      let(:players) do
        [
          WarPlayer.new([]),
          WarPlayer.new([]),
          WarPlayer.new([]),
          WarPlayer.new([])
        ]
      end

      it 'shuffles and distributes equal number cards to each player' do
        expect(players[0].cards.count).to eq 0
        expect(players[1].cards.count).to eq 0
        expect(players[2].cards.count).to eq 0
        expect(players[3].cards.count).to eq 0
        game.deal

        expect(players[0].cards.count).to eq 13
        expect(players[1].cards.count).to eq 13
        expect(players[2].cards.count).to eq 13
        expect(players[3].cards.count).to eq 13
      end
    end
  end

  describe '#play_war_round' do
    let(:players) do
      [
        WarPlayer.new([Card.new('H', 'A'), Card.new('D', 'J')]),
        WarPlayer.new([Card.new('S', '5'), Card.new('D', '10')])
      ]
    end
    subject(:game) { Game.new(players) }

    it 'plays one card from each player' do
      players.each do |player|
        expect(player).to receive(:play).and_call_original.once
      end
      game.play_war_round
    end

    it 'adds played cards to winning player\'s winnings' do
      player1 = players.first
      player2 = players.last

      game.play_war_round

      expect(player1.winnings.length).to eq 2
      expect(player2.winnings.length).to eq 0
    end

    context 'with matching first card' do
      let(:players) do
        [
          WarPlayer.new([Card.new('S', '7'), Card.new('H', 'A'), Card.new('D', 'J'), Card.new('C', 'K'), Card.new('D', 'A')]),
          WarPlayer.new([Card.new('D', '7'), Card.new('S', '5'), Card.new('D', '10'), Card.new('S', 'A'), Card.new('S', 'J')])
        ]
      end

      it 'plays a second card to determine tie breaker' do
        players.each do |player|
          expect(player).to receive(:play).and_call_original.once
          expect(player).to receive(:play).with(3).and_call_original.once
          expect(player).to receive(:play).and_call_original.once
        end
        game.play_war_round
      end

      it 'adds played cards to winning player\'s winnings' do
        player1 = players.first
        player2 = players.last

        game.play_war_round
        expect(player1.winnings.length).to eq 10
        expect(player2.winnings.length).to eq 0
      end

      context 'player runs out of cards during tie breaker' do
        let(:players) do
          [
            WarPlayer.new([Card.new('S', '7'), Card.new('H', 'A'), Card.new('H', '9'), Card.new('H', '3'), Card.new('D', 'J')]),
            WarPlayer.new([Card.new('D', '7')])
          ]
        end

        it 'adds played cards to winning player\'s winnings' do
          player1 = players.first
          player2 = players.last

          game.play_war_round

          expect(player1.winnings.length).to eq 6
          expect(player2.winnings.length).to eq 0
        end
      end
    end

    context 'player is out of cards' do
      let(:players) do
        [
          WarPlayer.new([Card.new('A', 'H'), Card.new('J', 'D')]),
          WarPlayer.new([])
        ]
      end

      it 'does not add any cards' do
        player1 = players.first
        player2 = players.last

        game.play_war_round

        expect(player1.cards.length).to eq 1
        expect(player2.cards.length).to eq 0
        expect(player1.winnings.length).to eq 1
        expect(player2.winnings.length).to eq 0

      end
    end

    context 'both players are out of cards' do
      let(:players) do
        [
          WarPlayer.new([]),
          WarPlayer.new([])
        ]
      end

      it 'does not add any cards' do
        player1 = players.first
        player2 = players.last

        game.play_war_round

        expect(player1.cards.length).to eq 0
        expect(player2.cards.length).to eq 0
        # TODO: Anything else?
      end

      # TODO: Should there be a pending test that both players out of cards raises an error?
    end
  end
end
