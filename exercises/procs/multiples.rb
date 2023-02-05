evens = (2..8).step(2).to_a
odds = (1..7).step(2).to_a

squares = proc { |num| num**2 }

s_evens, s_odds = [evens, odds].map { |array| array.map(&squares) }
p s_evens
p s_odds
