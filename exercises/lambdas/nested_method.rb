def outer_method
  # rubocop:disable Lint/NestedMethodDefinition
  def inner_method
    # rubocop:disable Style/RedundantReturn
    return
    # rubocop:enable Style/RedundantReturn
  end
  # rubocop:enable Lint/NestedMethodDefinition

  # Call the inner method
  inner_method

  # One more line - does this run? YES!
  puts "This is the outer method"
end

outer_method
# Output:
# This is the outer method
