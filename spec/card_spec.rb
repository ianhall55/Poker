require 'card'

describe Card do
  subject(:card){Card.new('4',:H)}

  describe '#value' do
    let (:face_card) {Card.new('K',:H)}

    it "should have a value" do
      expect(card.value).to eq(4)
    end

    it 'should have values for face cards' do
      expect(face_card.value).to eq(13)
    end
  end
end
