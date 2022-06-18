require './player.rb'
require './color_module.rb'

class Game
  attr_reader :NUM_OF_GUESSES
  attr_reader :player_roles
  attr_reader :player
  attr_reader :computer

  NUM_OF_GUESSES = 12

  ROLES = {
    "1" => "master",
    "2" => "breaker"
  }

  include Color

  def initialize(role_key)
    @player = Player.new(ROLES[role_key])
    @computer = Computer.new(role_key == "1" ? "breaker" : "master")
  end

  private

  def check_differences(code, guessed_code)
    guessed_code_array = guessed_code.split('')
    correct_numbers = Hash.new(0)

    guessed_code_array.each_with_index do |number, index|
      if code.include?(number)
        if code[index] == number
          correct_numbers[:in_order] += 1
        else
          correct_numbers[:not_in_order] += 1
        end
      end
    end
    correct_numbers
  end

  public

  def start
    code = player.breaker? ? computer.generate_code : player.generate_code

    1.upto(NUM_OF_GUESSES) do |count|
      guessed_number = player.breaker? ? player.guess_number : computer.guess_number

      puts "Turn ##{count}:"

      result = check_differences(code, guessed_number)

      if result[:in_order] == 4
        puts "Yay you did it!"
        break

      else
        sleep(1) if computer.breaker?

        guessed_number.split('').each { |number| print "#{Color.NUMBER_COLORS[number]} " }
        puts "\n"
        puts "#{result[:in_order]} correct guesses in correct order".green
        puts "#{result[:not_in_order]} correct guesses in incorrect order".yellow

        if count == NUM_OF_GUESSES

          loss_message = player.breaker? ? "Too bad.. You didn't make it." : "Computer-san lost.. minimax algorithm is needed."

          print "\n#{loss_message} The code was "
          code.split('').each { |number| print "#{Color.NUMBER_COLORS[number]} " }
          puts "\n"

        end

      end
    end
  end
end

loop do
  puts "Press 1 if you want to be the code master."
  puts "Press 2 if you want to be the code breaker."

  role_key = gets.chomp

  unless role_key == "1" || role_key == "2"
    puts "Invalid key".red

  else
    mastermind = Game.new(role_key)
    mastermind.start

    puts "Play again? (Press 'y' for yes or any other key for no)"
    answer = gets.chomp

    break unless answer == "y"

  end
end
