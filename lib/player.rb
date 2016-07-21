require_relative 'hand.rb'

class Player
  attr_accessor :pot, :hand, :current_bet, :name

  def initialize(name, pot)
    @hand = Hand.new
    @pot = pot
    @current_bet = 0
    @name = name
  end




end
