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

  def actions
    puts "1. Пропустить ход"
    puts "2. Добавить карту"
    puts "3. Открыть карты"
  end

  def exec_actions(choice)
    case choice
      when 1
        dealer_choose
      when 2
        player_choose
      when 3
        open_cards
    end
  end

  def welcome
    puts
    puts "            ♧  ♡  ♢  ♤ Black Jack ♧  ♡  ♢  ♤"
    puts
    puts "Введите ваше имя: "
    @name = gets.capitalize.chomp
    @player = CardPlayer.new(@name)
    @dealer = ComputerPlayer.new
    puts "Добро пожаловать в игру Black Jack, #{@name}"
    puts "Сейчас на Вашем счету #{player.bank_player} монет"
  end

  def begin_play
    puts"================== ♧  ♡  ♢  ♤ =================="
    puts "Перемешиваем колоду и раздаем каждому по 2 карты: "
    screenplay
    distribution_of_cards
    puts "У вас на руках: "
    turn_player
    @player.show_cards
    puts "Итого очков: #{@player.amount_cards}"
    bet
    puts "Ставка в банк 10 монет. На вашем счету: #{@player.bank}"
    turn_dealer
    puts "У дилера на руках  ♧  ♡  ♢  ♤ "
  end

  private

  def open_cards
    puts "Вскрываем карты: "
    puts "Карты игрока: #{@player.show_cards} | Очков: #{@player.amount_cards}"
    puts "Карты дилера: #{@dealer.show_cards} | Очков: #{@dealer.amount_cards}"
    if  21-@player.sum < 21-@dealer.sum && @player.sum <= 21
      puts "Вы победили!!!"
      puts "У вас в банке #{@player.bank_player_win}"
    elsif
    21-@player.sum == 21-@dealer.sum
      puts "Ничья"
    else
      puts "Дилер выйграл"
    end
    play_again
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