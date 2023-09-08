require 'spec_helper'

RSpec.describe 'Dealer class' do
  it 'can instantiate' do
    dealer = Dealer.new

    expect(dealer).to be_a(Dealer)
  end
end
