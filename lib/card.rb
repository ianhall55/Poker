require 'colorize'

class Card
  attr_reader :face, :suit

  def initialize(face,suit)
    @face = face
    @suit = suit
  end

  def value
    return get_num if check_if_num?
  end

  def to_s
    case @suit
    when :H
      "#{@face}\u2665".colorize(:color => :red, :background => :white)
    when :C
      "#{@face}\u2663".colorize(:color => :black, :background => :white)
    when :D
      "#{@face}\u2666".colorize(:color => :red, :background => :white)
    when :S
      "#{@face}\u2660".colorize(:color => :black, :background => :white )
    end
  end


  private
  def check_if_num?
    @face[0].to_i > 0
  end

  def get_num
    return @face[0].to_i unless @face[0].to_i == 1
    10
  end


end
