# Input
evens = [2, 4, 6, 8]
odds = [1, 3, 5, 7]

squares = proc { |x| x**2 }

even_squares = evens.map(&squares)
odd_squares = odds.map(&squares)

p even_squares
p odd_squares
