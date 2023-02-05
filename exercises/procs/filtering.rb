nums = (1..5).to_a

is_even = proc { |num| num.even? }
is_odd = proc { |num| num.odd? }

p nums.select(&is_even)
p nums.select(&is_odd)
