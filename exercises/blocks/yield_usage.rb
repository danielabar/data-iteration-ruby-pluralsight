my_list = %w[Milk Bread Fruits Greens]

def print_list(my_list)
  counter = 0
  puts "Printing the list\n"
  yield
  my_list.each { |item| print "#{counter += 1} - #{item} \n" }
  yield
end

print_list(my_list) do
  puts "**********"
end
