require 'card'

describe Card do
  subject(:card){Card.new('4',:H)}

  it "should have a value" do
    puts card.to_s
    expect(card.value).to eq(4)
  end
end
