def greet(question, &my_block)
  puts question
  name = gets.chomp
  my_block.call(name)
end

greet("What's your name?") do |name|
  puts "Hello #{name}"
end
