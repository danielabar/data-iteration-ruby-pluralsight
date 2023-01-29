hash = { name: "John", age: 18 }

hash.each do |key, value|
  puts "key: #{key}, value: #{value}"
end

hash.each_key { |key| puts "key: #{key}" }

hash.each_value { |value| puts "value: #{value}" }
