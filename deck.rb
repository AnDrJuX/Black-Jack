class Deck

  attr_accessor :cards

  def initialize
    @value = %w[2 3 4 5 6 7 8 9 10 J Q K A]
    @suits = %w[♧ U+2667 ♡ U+2661 ♢ U+2662 ♤ U+2664]
    @score = { "J" => 10, "Q" => 10, "K" => 10, "A" => 11 }
    @cards = []
  end

  def create_deck
    @value.each do |val|
      @suits.each do |suit|
        point = @score.key?(val) ? @score[val] : val.to_i
        @cards << [val, suit, point]
      end
    end
  end

  def give_cards(number)
    @cards.shuffle.shift(number)
  end
end