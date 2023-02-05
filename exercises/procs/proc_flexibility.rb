evens = (2..8).step(2).to_a
odds = (1..7).step(2).to_a

power = proc { |num, exponent| num**exponent }

s_evens, s_odds = [evens, odds].map { |array| array.map { |num| power.call(num, 2) } }
c_evens, c_odds = [evens, odds].map { |array| array.map { |num| power.call(num, 3) } }

p s_evens
p s_odds
p c_evens
p c_odds
