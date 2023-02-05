# Declare a method that doesn't accept any parameters
def my_method
  puts "Inside my method"
  yield
end

# Declare a proc and assign to `my_proc` variable
my_proc = proc { puts "Inside the proc" }

# Invoke `my_method` with `my_proc`
my_method(&my_proc)
