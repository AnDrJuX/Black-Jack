class Player

  attr_accessor :name, :bank, :hold_cards, :sum

  BANK = 100

  def initialize(name)
    @name = name
    @bank = BANK
    @bank_win = 0
    @hold_cards = []
    @sum = sum
  end

  def bank_player
    @bank
  end

  def bank_player_win
    @bank + @bank_win
  end

  def bank_pull
    @bank -= 10
    @bank_win += 20
  end

  def show_cards
    @hold_cards.flatten.each.with_index(1) do |item, index|
      print  "#{item} " unless (index %3 == 0)
    end
    puts
  end

  def drop_cards
    @hold_cards.clear
  end

  def amount_cards
    @sum = 0
    @hold_cards.flatten.each.with_index(1) do |item, index|
      @sum += item if (index %3 == 0)
    end
    check_ace
    @sum
  end

  def check_ace
    aces = @hold_cards.flatten.count {|ace| ace == "A"}
    if aces > 2
      @sum -= 20
    elsif aces > 1
      @sum -= 10
    else
      @sum
    end
  end

end