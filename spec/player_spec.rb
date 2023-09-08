require 'spec_helper'

RSpec.describe 'Player Class' do
  describe 'Can be instantiated and contains state' do
    it 'can be instantiated' do
      player = Player.new

      expect(player).to be_a(Player)
    end
    it 'contains state' do
      player = Player.new

      expect(player.hand_value).to eq(0)
      expect(player.hand_cards).to eq([])
    end
  end
  describe 'instance methods' do
    it 'recieve_card' do
      player = Player.new
      card = Card.new('Ace', 'Spades', 11)

      expect(player.hand_cards.length).to eq(0)
      player.recieve_card(card)
      expect(player.hand_cards.length).to eq(1)
    end

    it 'new_game' do
      player = Player.new
      card = Card.new('Ace', 'Spades', 11)

      player.recieve_card(card)
      expect(player.hand_cards.length).to eq(1)
      player.new_game
      expect(player.hand_cards.length).to eq(0)
    end

    it 'show_hand' do
      player = Player.new
      card = Card.new('Ace', 'Spades', 11)
      player.recieve_card(card)

      expect(player.show_hand).to eq([card])
    end

    it 'get_hand_value' do
      player = Player.new
      card = Card.new('Ace', 'Spades', 11)
      player.recieve_card(card)

      expect(player.get_hand_value).to eq(11)
    end

    it 'check_for_low_aces' do
      player = Player.new
      card = Card.new('Ace', 'Spades', 11)
      card_2 = Card.new('Ace', 'Hearts', 11)
      player.recieve_card(card)
      player.recieve_card(card_2)

      expect(player.get_hand_value).to eq(22)
      player.check_for_low_aces
      expect(player.get_hand_value).to eq(12)
    end
  end
end
