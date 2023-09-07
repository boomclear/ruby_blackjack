class Player
  attr_reader :name, :hand_value, :hand_cards

  def initialize(name)
    @hand_value = 0
    @hand_cards = []
    @name = name
  end

  def recieve_card(card)
    @hand_cards.push(card)
  end

  def new_game
    @hand_cards = []
  end

  def show_hand
    @hand_cards.each do |card|
      puts "#{card.name} of #{card.suit}"
    end
  end

  def get_hand_value
    value = 0
    @hand_cards.each do |card|
      value += card.value
    end
    @hand_value = value
    @hand_value
  end

  def check_for_low_aces
    return unless @hand_value > 21

    ace = @hand_cards.find do |card|
      card.name == 'Ace' && card.value != 1
    end
    return unless ace

    ace.value = 1
  end
end
