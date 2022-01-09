require "./Player"

class Game
  attr_accessor :player1, :player2
  
  def initialize
    @player1 = Player.new("Player 1")
    @player2 = Player.new("Player 2")
    @current_player = {}
    @turn_num = 0
  end

  def start
    while self.player1.is_alive? && self.player2.is_alive?
      puts " --- NEW TURN --- "

      #which players turn?
      if @turn_num % 2 == 0
        @current_player = @player1
      else
        @current_player = @player2
      end

      #ask a question to the player & check if they answer correct
      correct = self.ask_question(@current_player)

      #remove a life if wrong
      if !correct
        @current_player.lose_life
      end

      #output the current score
      puts "P1: #{@player1.lives}/3 vs P2: #{@player2.lives}/3"
      @turn_num += 1
    end

    if @player1.is_alive?
      puts "Player 1 wins with a score of #{@player1.lives}/3"
    else
      puts "Player 2 wins with a score of #{@player2.lives}/3"
    end
  end


  def ask_question(current_player)
    num1 = rand(1..20)
    num2 = rand(1..20)
    answer = num1 + num2
    
    puts "#{current_player.name}: What does #{num1} plus #{num2} equal?"
    print "> "
    input = gets.chomp.to_i

    if answer == input
      puts "#{current_player.name}: Yes! You are correct!"
      return true
    else
      puts "#{current_player.name}: Seriously?! That's so wrong buddy."
      return false
    end
  end

end