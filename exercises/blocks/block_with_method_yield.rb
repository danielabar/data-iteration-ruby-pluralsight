def my_method
  puts "Inside my method"
  yield
end

my_method do
  puts "Block as argument"
end
