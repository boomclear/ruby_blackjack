require_relative 'player'
require_relative 'dealer'

class Game

  def initialize(deck)
    @deck = deck
    @player_bust = false
    @player_stay = false
    @dealer_stay = false
    @player_bust = false
    @deck.create_deck
    @deck.shuffle_deck
    @main_menu = true
  end

  def main_menu
    @main_menu = true
    puts 'Welcome to BlackJack'
    puts 'Enter P to Play or Enter Q to Quit'
    player_choice = gets.chomp.upcase
    if player_choice == 'P'
      @player = Player.new
      @dealer = Dealer.new
      game_start
    elsif player_choice == 'Q'
      puts 'Goodbye!'
    else
      puts 'Please enter either P or Q'
      main_menu
    end
  end

  def game_start
    # the unless conditions are confirming that we aren't looping into another game while we select a new game through main_menu
    @main_menu = false
    start unless @main_menu
    blackjack_check unless @main_menu
    player_turn unless @main_menu
    dealer_turn unless @main_menu
    game_results unless @main_menu
  end

  def game_results
    if @dealer.hand_value > 21
      player_win
    elsif @player.hand_value > @dealer.hand_value
      player_win
    elsif @player.hand_value < @dealer.hand_value
      player_loss
    elsif @player.hand_value == @dealer.hand_value
      game_tie
    end
  end

  def player_blackjack
    puts 'Blackjack! You win!'
    @main_menu = true
    main_menu
  end

  def player_win
    puts 'You win!'
    @main_menu = true
    main_menu
  end

  def dealer_blackjack
    puts 'Dealer hand:'
    @dealer.show_hand
    puts 'Blackjack! You lose!'
    @main_menu = true
    main_menu
  end

  def player_loss
    if @player_bust
      puts 'Your hand value:'
      puts @player.hand_value
    end
    puts 'You lose!'
    @main_menu = true
    main_menu
  end

  def game_tie
    puts 'Tie!'
    @main_menu = true
    main_menu
  end

  def game_reset
    @player_bust = false
    @player_stay = false
    @dealer_stay = false
    @dealer_bust = false
  end

  def start
    game_reset
    @player.recieve_card(@deck.draw)
    @dealer.recieve_card(@deck.draw)
    puts 'Dealer Has:'
    @dealer.show_hand
    @player.recieve_card(@deck.draw)
    @dealer.recieve_card(@deck.draw)
    puts 'You have:'
    @player.show_hand
    @player.get_hand_value
    puts 'Hand value:'
    puts @player.hand_value
  end

  def player_hit
    @player.recieve_card(@deck.draw)
    puts 'Your new hand is:'
    @player.show_hand
    @player.get_hand_value
    @player.check_for_low_aces
    puts 'Hand value:'
    puts @player.hand_value
  end

  def player_stay
    @player_stay = true
    puts 'Your hand value:'
    puts @player.hand_value
  end

  def player_turn
    while !@player_bust && !@player_stay

      @player.get_hand_value
      if @player.hand_value <= 21
        puts 'Hit (H) or Stay (S)?'
        player_choice = gets.chomp.upcase
        if player_choice == 'H'
          player_hit
        elsif player_choice == 'S'
          player_stay
        else
          puts 'Please either input H for hit or S for stay'
        end
      elsif @player.hand_value > 21 && !@player.check_for_low_aces
        @player_bust = true
        player_loss
      end
    end
  end

  def dealer_turn
    while !@dealer_bust && !@dealer_stay

      @dealer.get_hand_value
      if @dealer.hand_value < 17
        @dealer.recieve_card(@deck.draw)
      elsif @dealer.hand_value > 21 && !@dealer.check_for_low_aces
        dealer_bust
      else
        dealer_stay
      end
    end
  end

  def dealer_bust
    @dealer_bust = true
    puts 'Dealer has:'
    @dealer.show_hand
    puts 'Dealer hand value:'
    puts @dealer.hand_value
  end

  def dealer_stay
    @dealer_stay = true
    puts 'Dealer has:'
    @dealer.show_hand
    puts 'Dealer hand value:'
    puts @dealer.hand_value
  end

  def blackjack_check
    if @player.blackjack? && @dealer.blackjack?
      game_tie
    elsif @player.blackjack?
      player_blackjack
    elsif @dealer.blackjack?
      dealer_blackjack
    end
  end
end
