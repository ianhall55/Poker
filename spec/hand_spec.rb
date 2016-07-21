require 'hand'

describe Hand do
  let(:card1) { double(:card, :value => 2,:suit => :H)}
  let(:card2) { double(:card, :value => 2,:suit => :C)}
  let(:card3) { double(:card, :value => 4,:suit => :D)}
  let(:card4) { double(:card, :value => 4,:suit => :S)}
  let(:card5) { double(:card, :value => 3,:suit => :S)}

  subject(:hand) {Hand.new([card1,card2,card3,card4,card5])}

  describe '#set_rank' do
    it "should set a hands rank" do
      hand.set_rank
      expect(hand.rank).to eq(7)
    end

    let(:c1) { double(:card, :value => 2,:suit => :H)}
    let(:c2) { double(:card, :value => 3,:suit => :H)}
    let(:c3) { double(:card, :value => 4,:suit => :H)}
    let(:c4) { double(:card, :value => 5,:suit => :H)}
    let(:c5) { double(:card, :value => 6,:suit => :H)}

    let(:straight_hand) {Hand.new([c1,c2,c3,c4,c5])}

    it "should set for straight flush" do
      straight_hand.set_rank
      expect(straight_hand.rank).to eq(1)
    end
  end

  describe '<=>' do
    let(:card6) { double(:card, :value => 2,:suit => :H)}
    let(:card7) { double(:card, :value => 2,:suit => :C)}
    let(:card8) { double(:card, :value => 4,:suit => :D)}
    let(:card9) { double(:card, :value => 4,:suit => :S)}
    let(:card0) { double(:card, :value => 10,:suit => :S)}

    let(:hand2) {Hand.new([card0,card6,card7,card8,card9])}

    it "should compare two hands" do
      expect(hand <=> hand2).to eq(-1)
    end

  end






end
