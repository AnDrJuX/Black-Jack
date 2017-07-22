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

  def play_again
    if (@player.bank != 0) && (@dealer.bank != 0)
      puts "Сыграем еще? У вас на счету #{@player.bank}"
      puts "Y/N"
      key = gets.chomp.capitalize
      if key == "Y"
        @player.drop_cards
        @dealer.drop_cards
        puts "Начнем!"
        begin_play
      else
        puts "Спасибо за игру! Увидимся еще!"
        exit
      end
    elsif (@player.bank = 0) || (@dealer.bank == 0)
      puts "Увы. Недостаточно денег в банке для игры"
      puts "До свидания!"
      exit
    end
  end

  def dealer_choose
    puts "Ход перешел к дилеру."
    screenplay
    if (@dealer.amount_cards <= 10)
      @dealer.hold_cards << @deck.give_cards(1)
      puts "Дилер взял одну карту. Ход перешел к Вам."
    else
      puts "Дилер не взял карту. Ход перешел к Вам."
    end
    cards_compare
  end

  def player_choose
    if (@player.hold_cards.size >= 2)
      puts "У вас 3 карты, больше брать нельзя"
    else
      @player.hold_cards << @deck.give_cards(1)
      @player.show_cards
      @player.amount_cards
      puts "Итого очков по итогу 3х карт: #{@player.sum}"
      if @player.sum > 21
        puts "У вас перебор"
        open_cards
      end
    end
    cards_compare
  end

  def cards_compare
    if @player.hold_cards.size == 2 && @dealer.hold_cards.size == 2
      puts "У каждого игрока по 3 карты. Вскрываем карты"
      open_cards
    end
  end

  def bet
    @player.bank_pull
    @dealer.bank_pull
  end

  def turn_player
    @player.hold_cards << @deck.give_cards(2)
  end

  def turn_dealer
    @dealer.hold_cards << @deck.give_cards(2)
  end

  def distribution_of_cards
    @deck.create_deck
  end

  def screenplay
    5.times do
      sleep(0.2)
      print " ♧  ♡  ♢  ♤ "
    end
    puts
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