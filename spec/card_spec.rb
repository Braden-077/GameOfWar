# frozen_string_literal: true

require 'card'

describe Card do
  it 'initializes without error' do
    expect { Card.new('D', 'J') }.not_to raise_error
  end

  it 'has a suit' do
    card = Card.new('D', 'J')
    expect(card.suit).to eq 'D'
  end

  it 'has a rank' do
    card = Card.new('D', 'J')
    expect(card.rank).to eq 'J'
  end

  it 'has a value' do
    card = Card.new('D', 'J')
    # 2 => 0, 3 => 1, ... , K => 11, A => 12
    expect(card.value).to eq 9
  end

  it 'does not allow for an invalid suit' do
    card = Card.new('INVALID', 'J')
    expect(card.suit).to eq 'This is an invalid suit.'
  end

  it 'does not allow for an invalid rank' do
    card = Card.new('S', 'INVALID')
    expect(card.rank).to eq 'This is an invalid rank.'
  end
end
