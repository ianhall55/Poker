




class Display

  def initialize

  end

  def render_hand(player)

    player.hand.cards.each {|c| print "#{c.to_s} " }
    puts ""
    puts " 0  1  2  3  4"
  end

  def render_play_state(pot, player, high_bet)
    clear
    puts "------------------------------------"
    puts "#{player.name}'s turn"
    puts "------------------------------------"
    puts "pot: #{pot}     | high bet: #{high_bet} "
    puts "------------------------------------"
    puts "available funds are #{player.pot}"
    puts "------------------------------------"
  end

  def clear
    system("clear")
  end


end
