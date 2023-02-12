proc = proc { puts "This is a Proc" }

# Rubocop: /style/Lambda
# my_lambda = lambda { puts "This is a Lambda" }
my_lambda = -> { puts "This is a Lambda" }

p proc.class
# Proc

p my_lambda.class
# Proc
