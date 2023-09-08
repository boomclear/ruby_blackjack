require 'spec_helper'

RSpec.describe 'Game class' do 
  it 'can be instantiated' do 
    deck = Deck.new
    game = Game.new(deck)

    expect(game).to be_a(Game)
  end
end