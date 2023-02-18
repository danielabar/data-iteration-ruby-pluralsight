to_inches = ->(meters) { meters * 39.37 }
to_feet = ->(meters) { meters * 3.28 }
to_yards = ->(meters) { meters * 1.09 }

def convert(meters, unit_lambda)
  unit_lambda.call(meters) if meters.is_a?(Numeric)
end

p convert(5, to_inches)
p convert(5, to_feet)
p convert(5, to_yards)
# 196.85
# 16.4
# 5.45

p [10, 25, 30].map(&to_inches)
# [393.7, 984.2499999999999, 1181.1]
