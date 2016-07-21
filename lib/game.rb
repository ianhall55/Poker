require_relative 'human_player.rb'
require_relative 'deck.rb'

require 'byebug'

class Game

  def initialize
    @players = [HumanPlayer.new('player1', 100), HumanPlayer.new('player2', 100)]
    @deck = Deck.new
    @pot = 0
    @players_in_hand = []
    @high_bet = 0
  end

  def play_poker
    new_hand
    play_hand
  end


  private
  def play_hand
    deal_cards
    1.times do
      get_actions
      break if @players_in_hand.count == 1
      get_discards
      deal_cards
    end
    get_actions unless @players_in_hand.count == 1
    find_winner
  end

  def new_hand
    @players_in_hand = @players.select {|play| play.pot > 0}
  end

  def deal_cards
    @deck.shuffle
    @players.each do |player|
      until player.hand.cards.count == 5
        player.hand.cards << @deck.cards.shift
      end
    end
  end

  def get_actions
    loop do
      @players.each do |player|
        player.render_play_state(@pot, @high_bet)
        action = player.get_action(@high_bet)
        handle(action, player)
      end
      break if @players_in_hand.count == 1 ||
               @players_in_hand.all? {|play| play.current_bet == @high_bet}
    end
    reset_bets
  end

  def get_discards
    @players_in_hand.each do |play|
      discards = play.discard
      discards.each {|pos| play.hand.delete_at(pos)}
    end
  end

  def reset_bets
    @players.each {|player| player.current_bet = 0}
    @high_bet = 0
  end

  def find_winner
    update_hand_ranks
    winner = nil
    winner = @players_in_hand.first if @players_in_hand.count == 1
    ranks = get_hand_ranks
    max_hand_rank = ranks.max
    @players_in_hand.select!{|player| player.hand.rank == max_hand_rank}
    if @players_in_hand.count == 1
      puts "#{@players_in_hand[0].name} is the winner"
    else
      case @players_in_hand[0].hand <=> @players_in_hand[1].hand
      when -1
        puts "#{@players_in_hand[1].name} is the winner"
      when 0
        puts "Draw betweent #{@players_in_hand[0].name} and #{@players_in_hand[1].name}"
      when 1
        puts "#{@players_in_hand[0].name} is the winner"
      end
    end
  end

  def get_hand_ranks
    ranks = []
    @players_in_hand.each do |player|
      ranks << player.hand.rank
    end
    ranks
  end

  def update_hand_ranks
    @players_in_hand.each {|player| player.hand.set_rank }
  end

  def handle(action, player)
    if action[0] == 0
      @players_in_hand.delete(player)
    elsif action[0] == 1
      see_amt = action[1]
      player.current_bet += see_amt
      @pot += see_amt
      player.pot -= see_amt
    else
      raise_amt = action[1]
      player.current_bet += raise_amt
      @high_bet += raise_amt
      @pot += raise_amt
      player.pot -= raise_amt
    end
  end


end

Game.new.play_poker
