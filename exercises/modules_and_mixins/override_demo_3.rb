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

class Printer
  include Printable

  # override `print` method from `Printable` module
  def print(item)
    "#{item} has been successfully printed to the printer."
  end
end

class InkjetPrinter < Printer
end

inkjet = InkjetPrinter.new

# `ancestors` method returns a list of modules included/prepended in mod (including mod itself).
p InkjetPrinter.ancestors
# [InkjetPrinter, Printer, Printable, Object, Kernel, BasicObject]

p inkjet.print("Page")
# "Page has been successfully printed to the printer."
