def my_method
  my_proc = proc { return "Exiting my_proc" }
  my_proc.call
  puts "End of method"
end

p my_method
# Output: Exiting my_proc
