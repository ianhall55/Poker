require 'deck'

describe Deck do
  subject(:deck) {Deck.new}

  describe '#count' do

    it 'should include 52 cards' do
      expect(deck.cards.count).to eq(52)
    end

  end

  describe '#shuffle' do
    let(:deck2) {Deck.new}

    it 'should shuffle' do
      expect(deck2.cards).to receive(:shuffle)
      deck2.shuffle
      expect(deck2.cards).to_not eq(deck.cards)
    end
  end

end
