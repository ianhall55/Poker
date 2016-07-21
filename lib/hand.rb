require_relative 'card.rb'
require 'byebug'

class Hand
  attr_accessor :cards
  attr_reader :rank

  HAND_RANKS = {straight_flush: 1,
                four_of_kind: 2,
                full_house: 3,
                flush: 4,
                straight: 5,
                three_of_kind: 6,
                two_pair: 7,
                one_pair: 8,
                high_card: 9}

  def initialize
    @cards = []
    @rank = 9
  end

  def set_rank
    temp_rank = 9
    temp_rank = HAND_RANKS[:one_pair] if one_pair?
    temp_rank = HAND_RANKS[:two_pair] if two_pair?
    temp_rank = HAND_RANKS[:three_of_kind] if three_of_kind?
    temp_rank = HAND_RANKS[:straight] if straight?
    temp_rank = HAND_RANKS[:flush] if flush?
    temp_rank = HAND_RANKS[:full_house] if full_house?
    temp_rank = HAND_RANKS[:four_of_kind] if four_of_kind?
    temp_rank = HAND_RANKS[:straight_flush] if straight_flush?
    @rank = temp_rank
  end


  def <=>(hand2)

    h1 = get_values_hash
    h2 = hand2.get_values_hash

    4.downto(1) do |i|
      next if h1["#{i}"].empty?
      return winner(h1,h2,i) if winner?(h1,h2,i)

    end
    0
  end

  protected
  def get_values_hash
    values = get_values.sort {|a,b| b<=>a}
    uniq_v = values.uniq
    h1 = Hash.new([])
    uniq_v.each do |v|
      values.count(v).times do
        h1[values.count(v).to_s] += [v]
      end
    end
    h1
  end

  private
  def get_values
    values = []
    @cards.each { |c| values << c.value}
    values
  end

  def winner(h1,h2,i)
    v1 = h1["#{i}"]
    v2 = h2["#{i}"]
    (0...v1.length).each do |val|
      return -1 if v1[val] < v2[val]
    end
    1
  end

  def winner?(h1,h2,i)
    v1 = h1["#{i}"]
    v2 = h2["#{i}"]
    (0...v1.length).each do |val|
      return true unless v1[val] == v2[val]
    end
    false
  end

  def get_suits
    suit = []
    @cards.each { |c| suits << c.suit}
    suit
  end

  def of_a_kind?(num)
    values = get_values
    (2..14).any? {|n| values.count(n) == num}
  end

  def straight_flush?
    return false unless flush? && straight?
    true
  end

  def four_of_kind?
    of_a_kind?(4)
  end

  def full_house?
    values = get_values
    return false unless values.uniq.count == 2
    return false if values.uniq.any? { |val| values.count(val) > 3}
    true
  end

  def flush?
    @cards.all? {|c| c.suit == @cards[0].suit}
  end

  def straight?
    values = get_values
    values.sort.each_with_index do |c, i|
      return false unless c == values[0] + i
    end
    true
  end

  def three_of_kind?
    of_a_kind?(3)
  end

  def two_pair?
    values = get_values
    return false unless values.uniq.count == 3
    return false if values.uniq.any? { |val| values.count(val) > 2}
    true
  end

  def one_pair?
    of_a_kind?(2)
  end




end
