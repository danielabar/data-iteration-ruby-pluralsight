module MeterConversion
  VERSION = 1.0

  def self.to_inches(meters)
    meters * 39.37
  end

  def self.to_feet(meters)
    meters * 3.28
  end

  def self.to_yards(meters)
    meters * 1.09
  end
end

puts MeterConversion::VERSION
puts MeterConversion.to_inches(5)
puts MeterConversion.to_feet(5)
puts MeterConversion.to_yards(5)
