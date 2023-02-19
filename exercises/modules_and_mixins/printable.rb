module Printable
  def print(item)
    "#{item} has been successfully printed."
  end
end

class Terminal
  include Printable
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

terminal = Terminal.new("Term")
p terminal.print("Page")
