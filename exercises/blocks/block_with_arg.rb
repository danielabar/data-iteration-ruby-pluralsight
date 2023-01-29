def greet
  puts "What's your name?"
  name = gets.chomp
  yield name
end

greet do |name|
  puts "Hello #{name}"
end
