require_relative 'card.rb'

class Deck
  attr_reader :cards

  def initialize
    @cards = set_cards
  end

  def count
    @cards.count
  end

  def shuffle
    @cards.shuffle!
  end

  private
  def set_cards
    deck = []
    suits = [:C, :D, :S, :H]
    suits.each do |suit|
      (2..10).each { |num| deck << Card.new(num.to_s, suit) }
      deck += face_cards(suit)
    end
    deck
  end

  def face_cards(suit)
    final = []
    cards = ['J', 'Q', 'K', 'A']
    cards.each {|card|final << Card.new(card, suit)}
    final
  end
end
