def my_method
  my_lambda = -> { return }
  my_lambda.call
  puts "End of method"
end

my_method
# Outputs: End of method
