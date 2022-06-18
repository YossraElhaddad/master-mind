require './colors.rb'

module Color
  NUMBER_COLORS = {
    "1" => "1".red.bold,
    "2" => "2".magenta.bold,
    "3" => "3".yellow.bold,
    "4" => "4".green.bold,
    "5" => "5".cyan.bold
  }

  def self.NUMBER_COLORS
    NUMBER_COLORS
  end
end
