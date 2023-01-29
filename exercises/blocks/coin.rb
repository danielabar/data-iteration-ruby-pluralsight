# Represents a coin that can be flipped.
#
# @attr_reader [Symbol] type The type of the coin, such as dime, quarter, or penny.
# @attr_reader [Hash] side The number of times the coin has landed heads or tails.
class Coin
  attr_reader :type, :side

  # Initializes a new instance of the Coin class.
  #
  # @param type [Symbol] The type of the coin being used, such as dime, quarter, or penny.
  #
  # @return [void]
  def initialize(type)
    @type = type
    @side = {
      heads: 0,
      tails: 0
    }
  end

  # Records that the coin turned up heads.
  #
  # @return [void]
  def turned_up_heads
    @side[:heads] += 1
    print "#{type} coin toss resulted in "
    yield
  end

  # Records that the coin turned up tails.
  #
  # @return [void]
  def turned_up_tails
    @side[:tails] += 1
    print "#{type} coin toss resulted in "
    yield
  end

  # Prints the current statistics for the coin.
  #
  # @return [void]
  def print_stats
    puts "=========="
    puts "Printing stats"
    puts "- Heads: #{side[:heads]}"
    puts "- Tails: #{side[:tails]}"
    puts "=========="
    yield self if block_given?
  end
end

# Start execution
coin = Coin.new("Dime")

# View initial status
coin.print_stats

# Make it heads once
coin.turned_up_heads { puts "heads" }

# Make it tails three times
1.upto(3) do
  coin.turned_up_tails { puts "tails" }
end

# Show current stats
coin.print_stats

# Show current stats, followed by custom stats
coin.print_stats do |coin_instance|
  puts "**********"
  puts "Printing stats when passing block"
  puts coin_instance.type.to_s
  puts coin_instance.side.to_s
  puts "**********"
end
