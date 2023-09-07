require 'spec_helper'

RSpec.describe 'Card Class' do
  describe 'Card can store and give state' do
    it 'Card can be instantiated' do
      card = Card.new('Two', 'Hearts', 2)

      expect(card).to be_a(Card)
    end

    it 'Card can give state' do
      card = Card.new('Two', 'Hearts', 2)

      expect(card.name).to eq('Two')
      expect(card.suit).to eq('Hearts')
      expect(card.value).to eq(2)
    end
  end
end
