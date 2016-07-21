require_relative 'player.rb'
require_relative 'display.rb'

class HumanPlayer < Player
  attr_reader :display

  def initialize(name, pot)
    super
    @display = Display.new
  end

  def discard
    @display.clear
    @display.render_hand(self)
    puts "#{@name}, which cards do you want to discard?"
    discard_indices = gets.chomp.split(",").map {|x| x.to_i }
    discard_indices.sort!.reverse!
  end

  def get_action(high_bet)
    @display.render_hand(self)
    puts "Do you want to fold(0), see(1), or raise(2)?"
    action = gets.chomp.to_i
    amount = nil
    case action
    when 2
      amount = get_raise_amount
    when 1
      amount = high_bet - @current_bet
      raise "You can't see that much" unless valid?(amount)
    end
    [action,amount]
  rescue StandardError => e
    puts e
    retry
  end

  def get_raise_amount
    puts "Please enter amount you want to raise by"
    amount = nil
    loop do
      amount = gets.chomp.to_i
      raise "Not a valid amount" unless valid?(amount)
      break
    end
    return amount
  end

  #render options
  def render_play_state(pot,high_bet)
    @display.render_play_state(pot, self, high_bet)
  end

  private
  def valid?(amount)
    @pot - amount >= 0
  end

end
