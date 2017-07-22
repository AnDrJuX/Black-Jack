require_relative 'player'
require_relative 'deck'
require_relative 'сard_player'
require_relative 'computer_player'

class Main
  attr_accessor :player, :dealer, :sum

  def initialize
    @player = player
    @dealer = dealer
    @deck = Deck.new
  end

end

start = Main.new
start.welcome
start.begin_play

loop do
  start.actions
  choice = gets.chomp.to_i
  start.exec_actions(choice)
end