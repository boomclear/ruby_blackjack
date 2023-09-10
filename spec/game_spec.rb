require 'spec_helper'

RSpec.describe 'Game class' do
  it 'can be instantiated' do
    deck = Deck.new
    game = Game.new(deck)
    expect(game).to be_a(Game)
  end
  describe 'main_menu output' do
    it 'welcomes the user and says Goodbye when user quits' do
      ui = spy('Fake Ui', get_input: 'Q')
      deck = Deck.new
      game = Game.new(deck, ui)
      expect(ui).to receive(:print).with 'Welcome to BlackJack'
      expect(ui).to receive(:print).with 'Enter P to Play or Enter Q to Quit'
      expect(ui).to receive(:print).with 'Goodbye!'
      game.main_menu
    end
    it 'starts the game if user inputs p' do
      ui = spy('FakeUi', get_input: 'P')
      deck = Deck.new
      game = Game.new(deck, ui)
      expect(game).to receive(:game_start).and_return nil
      game.main_menu
    end
    it 'instructs the user to give valid input' do
      ui = spy('FakeUi')
      deck = Deck.new
      game = Game.new(deck, ui)
      expect(ui).to receive(:print).with 'Please enter either P or Q'
      expect(ui).to receive(:get_input).and_return 'a', 'Q'
      game.main_menu
    end
  end
  describe 'game_start methods' do
    it 'game_start calls on various helper methods' do
      deck = Deck.new
      game = Game.new(deck)

      expect(game).to receive(:start).and_return 'start'
      expect(game).to receive(:blackjack_check).and_return 'blackjack_check'
      expect(game).to receive(:player_turn).and_return 'player_turn'
      expect(game).to receive(:dealer_turn).and_return 'dealer_turn'
      expect(game).to receive(:game_results).and_return 'game_results'

      expect(game.game_start).to eq('game_results')
    end
  end
  describe 'game_results conditions' do
    it 'if dealer busts player wins' do
      deck = Deck.new
      game = Game.new(deck)

      expect(game).to receive(:player_win).and_return 'player_win'
      game.dealer.hand_value = 22
      expect(game.game_results).to eq('player_win')
    end
    it "if player's hand value is more than the dealer, player win" do
      deck = Deck.new
      game = Game.new(deck)

      expect(game).to receive(:player_win).and_return 'player_win'
      game.dealer.hand_value = 2
      game.player.hand_value = 3
      expect(game.game_results).to eq('player_win')
    end
    it "if dealer's hand value is over player's then player loss" do
      deck = Deck.new
      game = Game.new(deck)

      expect(game).to receive(:player_loss).and_return 'player_loss'
      game.dealer.hand_value = 3
      game.player.hand_value = 2
      expect(game.game_results).to eq('player_loss')
    end
    it "if dealer's and player's hand value is the same, game_tie" do
      deck = Deck.new
      game = Game.new(deck)

      expect(game).to receive(:game_tie).and_return 'game_tie'
      game.dealer.hand_value = 3
      game.player.hand_value = 3
      expect(game.game_results).to eq('game_tie')
    end
  end
  describe 'game win/loss/tie conditions' do
    it 'player_blackjack puts message and returns main_menu' do
      ui = spy('FakeUi')
      deck = Deck.new
      game = Game.new(deck, ui)
      expect(ui).to receive(:print).with 'Blackjack! You win!'
      expect(game).to receive(:main_menu).and_return 'main_menu'
      expect(game.player_blackjack).to eq('main_menu')
    end
    it 'player_win puts message and returns main_menu' do
      ui = spy('FakeUi')
      deck = Deck.new
      game = Game.new(deck, ui)
      expect(ui).to receive(:print).with 'You win!'
      expect(game).to receive(:main_menu).and_return 'main_menu'
      expect(game.player_win).to eq('main_menu')
    end
    it 'dealer_blackjack puts message and returns main_menu' do
      ui = spy('FakeUi')
      deck = Deck.new
      game = Game.new(deck, ui)
      expect(ui).to receive(:print).with 'Dealer hand:'
      expect(ui).to receive(:print).with 'Blackjack! You lose!'
      expect(game).to receive(:main_menu).and_return 'main_menu'
      expect(game.dealer_blackjack).to eq('main_menu')
    end
    it 'player_loss puts message and returns main_menu' do
      ui = spy('FakeUi')
      deck = Deck.new
      game = Game.new(deck, ui)
      expect(ui).to receive(:print).with 'You lose!'
      expect(game).to receive(:main_menu).and_return 'main_menu'
      expect(game.player_loss).to eq('main_menu')
    end
    it 'game_tie puts message and returns main_menu' do
      ui = spy('FakeUi')
      deck = Deck.new
      game = Game.new(deck, ui)
      expect(ui).to receive(:print).with 'Tie!'
      expect(game).to receive(:main_menu).and_return 'main_menu'
      expect(game.game_tie).to eq('main_menu')
    end
  end
  describe 'start puts some text for the user on screen' do
    it 'shows text' do
      ui = spy('FakeUi')
      deck = Deck.new
      game = Game.new(deck, ui)
      expect(ui).to receive(:print).with 'Dealer Has:'
      expect(ui).to receive(:print).with 'You have:'
      expect(ui).to receive(:print).with 'Hand value:'
      game.start
    end
  end
  describe 'player_actions displays some text' do
    it 'player_hit displays some text' do
      ui = spy('FakeUi')
      deck = Deck.new
      game = Game.new(deck, ui)
      expect(ui).to receive(:print).with 'Your new hand is:'
      expect(ui).to receive(:print).with 'Hand value:'
      game.player_hit
    end
    it 'player_stay displays some text' do
      ui = spy('FakeUi')
      deck = Deck.new
      game = Game.new(deck, ui)
      expect(ui).to receive(:print).with 'Your hand value:'
      game.player_stay
    end
  end
end