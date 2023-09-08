require 'spec_helper'

RSpec.describe 'Deck Class' do
  describe 'Deck can store and give state' do
    it 'Deck can be instantiated' do
      deck = Deck.new

      expect(deck).to be_a(Deck)
    end

    it 'Deck can give state' do
      deck = Deck.new

      expect(deck.deck_of_cards).to eq([])
    end
  end
  describe 'instance methods' do
    it 'can create the deck' do
      deck = Deck.new

      expect(deck.deck_of_cards.length).to eq(0)
      deck.create_deck
      expect(deck.deck_of_cards.length).to eq(312)
    end
    it 'can shuffle deck' do
      deck = Deck.new
      unshuffled = deck.create_deck.first
      shuffled = deck.shuffle_deck.first
      expect(unshuffled).to_not eq(shuffled)
    end
    it 'can draw a card' do
      deck = Deck.new

      deck.create_deck
      deck.shuffle_deck
      card = deck.deck_of_cards.last
      expect(deck.deck_of_cards.length).to eq(312)
      expect(deck.draw).to eq(card)
      expect(deck.deck_of_cards.length).to eq(311)
    end
  end
end
