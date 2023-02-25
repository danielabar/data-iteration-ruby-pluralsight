module Printable
  def print(item)
    "#{item} has been successfully printed."
  end
end

class Terminal
  include Printable

  # override `print` method from `Printable` module
  def print(item)
    "#{item} has been successfully printed to the console."
  end
end

terminal = Terminal.new
p terminal.print("screen")
