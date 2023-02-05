evens = (2..8).step(2).to_a
odds = (1..7).step(2).to_a

squares = proc { |num| num**2 }
cubes = proc { |num| num**3 }

s_evens, s_odds = [evens, odds].map { |array| array.map(&squares) }
c_evens, c_odds = [evens, odds].map { |array| array.map(&cubes) }

p s_evens
p s_odds
p c_evens
p c_odds
