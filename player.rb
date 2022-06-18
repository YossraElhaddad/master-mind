require './colors.rb'

class Player
  attr_reader :role

  def initialize(role)
    @role = role
  end

  def breaker?
    role == "breaker"
  end

  private

  def bounded?(code)
    code.split('').none? { |number| number.to_i > 5 || number.to_i == 0 }
  end

  public

  def generate_code
    loop do
      puts "Make a 4-digit number between (1-5) for the computer to guess:"
      number_to_be_guessed = gets.chomp

      unless number_to_be_guessed.length == 4 && bounded?(number_to_be_guessed)
        puts "Invalid number. Try again".red

      else
        return number_to_be_guessed

      end
    end
  end

  def guess_number
    loop do
      puts "Guess a 4-digit number between (1-5):"
      guessed_number = gets.chomp

      unless guessed_number.length == 4 && bounded?(guessed_number)
        puts "Invalid number. Try again".red

      else
        return guessed_number

      end
    end
  end
end

class Computer < Player
  def initialize(role)
    super(role)
  end

  def generate_code
    code_array = Array.new(4)
    code_array.map! { |number| number = rand(1..5) }
    code_array.join.to_s
  end

  def guess_number
    generate_code
  end
end
