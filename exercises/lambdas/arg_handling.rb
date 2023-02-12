# A proc that accepts a single argument
my_proc = proc { |name| puts "Name is #{name}" }

# Call a proc with expected number of args
my_proc.call("John")
# Name is John

# Call a proc with too many args
my_proc.call("John", "Doe")
# Name is John

# Call a proc with no args
my_proc.call
# Name is

# A lambda that accepts a single arguemnt
my_lambda = ->(name) { puts "Name is #{name}" }

# Call a lambda with expected number of args
my_lambda.call("John")
# Name is John

# Call a lambda with too many args
my_lambda.call("John", "Doe")
# arg_handling.rb:14:in `block in <main>': wrong number of arguments (given 2, expected 1) (ArgumentError)

# Call a lambda with no args
my_lambda.call
# arg_handling.rb:17:in `block in <main>': wrong number of arguments (given 0, expected 1) (ArgumentError)
