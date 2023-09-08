class Deck
  attr_accessor :deck_of_cards

  def initialize
    @deck_of_cards = []
  end

  def create_deck
    suits = %w[Hearts Diamonds Spades Clubs]
    names = %w[
      Ace
      King
      Queen
      Jack
      Ten
      Nine
      Eight
      Seven
      Six
      Five
      Four
      Three
      Two
    ]
    values = [11, 10, 10, 10, 10, 9, 8, 7, 6, 5, 4, 3, 2]

    6.times do
      suits.each do |suit|
        value_index = 0
        names.each do |name|
          @deck_of_cards.push(Card.new(name, suit, values[value_index]))
          value_index += 1
        end
      end
    end
    @deck_of_cards
  end

  def shuffle_deck
    current_index = @deck_of_cards.length
    while current_index != 0
      random_index = rand(current_index)
      current_index -= 1
      temporary_value = @deck_of_cards[current_index]
      @deck_of_cards[current_index] = @deck_of_cards[random_index]
      @deck_of_cards[random_index] = temporary_value
    end
    @deck_of_cards
  end

  def draw
    @deck_of_cards.pop
  end
end
