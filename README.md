<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Data Iteration with Ruby](#data-iteration-with-ruby)
  - [Working with Blocks](#working-with-blocks)
    - [Introducing Blocks](#introducing-blocks)
    - [Writing a Block](#writing-a-block)
    - [Writing a Block Method](#writing-a-block-method)
    - [Block with Arguments](#block-with-arguments)
    - [Calling a Block with the Call Method](#calling-a-block-with-the-call-method)
    - [Demo: Using the Yield Keyword](#demo-using-the-yield-keyword)
    - [Using Blocks with Built-in Types](#using-blocks-with-built-in-types)
    - [Demo: Implementing a Coin Flip](#demo-implementing-a-coin-flip)
  - [Using Procs and Lambdas](#using-procs-and-lambdas)
    - [Working with Procs](#working-with-procs)
    - [Working with Lambdas](#working-with-lambdas)
    - [Demo: Unit Conversion with Lambda](#demo-unit-conversion-with-lambda)
  - [Adding Functionality with Mixins](#adding-functionality-with-mixins)
    - [Modules and Mixins](#modules-and-mixins)
    - [The Include Statement](#the-include-statement)
    - [The Enumerable Mixin](#the-enumerable-mixin)
    - [Overriding Methods](#overriding-methods)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Data Iteration with Ruby

My notes from [Pluralsight Course](https://app.pluralsight.com/library/courses/data-iteration-ruby/table-of-contents) on data iteration with Ruby.

## Working with Blocks

### Introducing Blocks

- Blocks are snippets of code that are grouped together to be executed later
- Block is *not* an object, but rather, a piece of syntax (exception to the rule in Ruby where otherwise, *everything* is an object.)
- Block is connected to a method call (cannot have a block without a corresponding method call)
- Block is not a method argument or parameter
- Defined with `{ ... }` or `do ... end`, braces have higher precedence. Convention is to use `do ... end` for multi-line statements, braces for single-line statements.

**Block vs Method**

- Block can only be invoked once (unlike method which can be invoked any number of times)
- Block does not persist after completed execution
- Block supports separating actions away from the method that its used with - i.e. use a block to customize functionality attached to method. Method will contain everything that stays the same, and block(s) would contain actions that are unique/custom.

### Writing a Block

Curly brace - a single statement `puts "Testing ..."` is connected to the `times` method:

```ruby
3.times { puts "Testing ..." }
```

Do End keywords:

```ruby
3.times do
  puts "Inside the block"
  puts "Still inside the block"
end
```

`times` iterator takes a number like `3` and executes statements inside the block (aka an action) that many times.

In the above example the `times` is the functionality that stays the same, but we customize the action it will perform via a block.

Another example - `each` method iterates over every item in the array, the block is where we put our custom code of what should be done on each iteration.

```ruby
array = [2, 3, 4]
array.each { |num| puts num.to_s }
```

`num` block variable defined within pipe characters gets set to each element in the array, in turn.

The same could be written using do end keywords:

```ruby
array = [2, 3, 4]
array.each do |num|
  puts num.to_s
end
```

### Writing a Block Method

Examples above included using built-in Ruby methods like `times` and `each` that accept blocks. We can also write our own methods to accept blocks. i.e. the block is considered an argument to the method.

**ASIDE: Parameter vs Argument**

* Parameter is a variable used within a method definition
* Argument is actual value corresponding to the parameter in the method definition
* Parameter used when defining a method
* Argument used when calling a method

Simple example:

```ruby
def my_method
  puts "Inside my method"
end

my_method do
  puts "Block as argument"
end
```

In the above code, the `my_method` method is called, passing in a block as an argument. When `my_method` runs, it outputs `Inside my method`. The `Block as argument` never gets executed. Because even though the block gets passed in, we didn't use it in `my_method`.

To make a method execute a block that's passed to it, use `yield` keyword:

```ruby
def my_method
  puts "Inside my method"
  # causes execution to jump out of `my_method`
  # and into whatever block got passed in to `my_method`
  yield
end

my_method do
  puts "Block as argument"
end
```

Output:

```
Inside my method
Block as argument
```

### Block with Arguments

Just like a method, a block can accept arguments.

Example:

```ruby
def greet
  puts "What's your name?"
  # `gets` is a method in Ruby that reads a line of input from the user and returns it as a string
  # `chomp` is a method that removes the line break character from the end of a string
  name = gets.chomp
  yield name
end

greet do |name|
  puts "Hello #{name}"
end
```

Running this in a terminal, entering some text like `Alice` will output:

```
What's your name?
(type in Alice at terminal)
Hello Alice
```

In the above example, `yield name` will pass the `name` variable as an argument to the block that got passed in to the `greet` method.

When the `greet` method is invoked with a block that specifies a `name` argument, it will receive this value from the `yield name` line in the `greet` method.

`name` variable's scope is limited to the block. Cannot access it outside of the block or `greet` method.

### Calling a Block with the Call Method

`yield` is just one way to invoke a block from within a method. Can also use the `call` method on a block, also a block can take multiple arguments.

Example:

```ruby
def greet(question, &my_block)
  puts question
  name = gets.chomp
  my_block.call(name)
end

greet("What's your name?") do |name|
  puts "Hello #{name}"
end
```

Running this in a terminal, entering some text like `Alice` will output the same as previous example:

```
What's your name?
(type in Alice at terminal)
Hello Alice
```

This time the `greet` method takes two params - a `question` string, and a block `my_block`.

Note `&` in parameter definition `&my_block` - this tells Ruby that this isn't an ordinary parameter, but rather a block parameter.

Instead of yield, the code invokes the block with `my_block.call(...)`.

When invoking the `greet` method, the first argument "What's your name?" becomes the value of the `question` parameter.

### Demo: Using the Yield Keyword

```ruby
my_list = %w[Milk Bread Fruits Greens]

def print_list(my_list)
  counter = 0
  puts "Printing the list\n"
  yield
  my_list.each { |item| print "#{counter += 1} - #{item} \n" }
  yield
end

print_list(my_list) do
  puts "**********"
end
```

Outputs:

```
Printing the list
**********
1 - Milk
2 - Bread
3 - Fruits
4 - Greens
**********
```

Notice `yield` can be called multiple times in a method.

`print_list` method is flexible in that if you want a different list separator such as "==========", only need to modify the block.

### Using Blocks with Built-in Types

Built-in: Utility classes that are part of the Ruby core library, eg: String, Integer, Array, Hash, etc.

**Using Blocks with Strings**

```ruby
my_string = "Ruby"
my_string.each_char{ |letter| print "#{letter} "}
```

Outputs:

```
R u b y %
```

`each_char` is a method on String that can be called with a block. `each_char` supports iterating over each letter in the string on which it's called.

Another example:

```ruby
i = 0
lang = "Ruby
Java
Pyton
C
"

lang.each_line { |line| print "#{i += 1} #{line}" }
```

Output:

```
1 Ruby
2 Java
3 Pyton
4 C
```

`lang` is a multi-line string.

Uses `each_line` method of String built-in type, that accepts a block, iterates over each line of a multi-line string.

**Using Blocks with Integers**

Example to print every integer from 2 through 6. Use [upto](https://rubyapi.org/3.1/o/integer#method-i-upto) method of built-in Integer type, which accepts a block. Call `upto` on Integer `2`, with argument  `6` and a block that prints out the number followed by a space.

```ruby
2.upto(6) { |num| print num, " " }
# 2 3 4 5 6 %
```

**Using Blocks with Arrays**

Using [delete_if](https://rubyapi.org/3.1/o/array#method-i-delete_if) method of Array built-in type.

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

print(arr.delete_if { |num| num > 7 })
# [1, 2, 3, 4, 5, 6, 7]
```

Note that `delete_if` modifies the array on which its called. Will remove elements that satisfy the given condition.

Use `reject` instead of `delete_if` to return a new array instead of modifying existing array:

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

print(arr.reject { |num| num > 7 })
print "\n", arr
# [1, 2, 3, 4, 5, 6, 7]
# [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]%
```

Use `count` method to find number of elements in the array for which the condition in the block returns true:

```ruby
arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
print(arr.count { |c| c == 9 })
# 1
```

**Using Block with Hashes**

`each` method can be used on a hash as well as array. It yields a key and value for each entry in the hash.

Can also iterate over only the keys with `each_key` method and just the values with `each_value`.

```ruby
hash = { name: "John", age: 18 }
hash.each do |key, value|
  puts "key: #{key}, value: #{value}"
end
# key: name, value: John
# key: age, value: 18

hash.each_key { |key| puts "key: #{key}" }
# key: name
# key: age

hash.each_value { |value| puts "value: #{value}" }
# value: John
# value: 18
```

### Demo: Implementing a Coin Flip

Putting together everything learned in this module.

[coin.rb](exercises/blocks/coin.rb)

Output:

```
==========
Printing stats
- Heads: 0
- Tails: 0
==========
Dime coin toss resulted in heads
Dime coin toss resulted in tails
Dime coin toss resulted in tails
Dime coin toss resulted in tails
==========
Printing stats
- Heads: 1
- Tails: 3
==========
==========
Printing stats
- Heads: 1
- Tails: 3
==========
**********
Printing stats when passing block
Dime
{:heads=>1, :tails=>3}
**********
```

## Using Procs and Lambdas

### Working with Procs

Proc: short for procedure, i.e. set of instructions packaged together to perform some task.

Ruby proc: Object that serves as a saved block.

Use a proc instead of a block if the same block is being used in multiple places. A Proc could replace this.

A proc is bound to a set of local variables.

**Diff**

Block is part of the syntax of a method call, whereas a Proc is an object, an instance of the Proc class.

Can call methods on a proc object, assign it to a variable.

Can only pass a single Block in a method arguments list. Whereas with a Proc, can pass multiple Proc objects to a method as arguments.

There's no way to call a block independently, it's only executed as part of the method. Whereas all Proc objects have a `call` method that can be invoked to execute it.

**Example**

Start with using blocks to find squares of two arrays. Notice use of the same block for squaring evens array and odds array. Because there's no way to persist blocks, they can't be re-used:

```ruby
# Input
evens = [2, 4, 6, 8]
odds = [1, 3, 5, 7]

square_of_evens = evens.map { |num| num**2 }
square_of_odds = odds.map { |num| num**2 }

p square_of_evens
p square_of_odds
```

Output:

```ruby
[4, 16, 36, 64]
[1, 9, 25, 49]
```

Procs can help to reduce code duplication. Implement again with a proc. Notice the proc can be assigned to a variable and passed as an argument to methods.

```ruby
# Input
evens = [2, 4, 6, 8]
odds = [1, 3, 5, 7]

# create a proc object, assign it to variable `squares`
squares = proc { |x| x**2 }

# prefix argument with ampersand `&` to tell Ruby this is a proc, not an ordinary variable
even_squares = evens.map(&squares)
odd_squares = odds.map(&squares)

p even_squares
p odd_squares
```

Same output as with blocks.

Procs can also be used to filter values:

```ruby
# Use Range to declare an array of integers from 1 to 5
nums = (1..5).to_a

# Define filters as procs
is_even = proc { |num| num.even? }
is_odd = proc { |num| num.odd? }

# Apply the filters to the array by passing the procs to the `select` method
# and display the output
p nums.select(&is_even)
p nums.select(&is_odd)
```

Outputs:

```ruby
[2, 4]
[1, 3, 5]
```

Procs can be defined using curly braces if single line, or `do ... end` keywords for multiline.

Procs provide all benefits of blocks, plus can be persisted in a variable.

Example below shows how proc can be passed to a method that doesn't accept any parameters:

```ruby
# Declare a method that doesn't accept any parameters
def my_method
  puts "Inside my method"
  # transfers execution to proc
  yield
end

# Declare a proc and assign to `my_proc` variable
my_proc = proc { puts "Inside the proc" }

# Invoke `my_method` with `my_proc`
my_method(&my_proc)
```

Outputs:

```
Inside my method
Inside the proc
```

This example shows how the `call` method of a proc can be invoked:

```ruby
greet = proc { puts "Hello world!" }
greet.call
# Hello world!
```

Example calculating squares of evens and odds array all in one line with Array `map` method:

```ruby
evens = (2..8).step(2).to_a
odds = (1..7).step(2).to_a

squares = proc { |num| num**2 }

# declare a nested array with each entry itself an array
s_evens, s_odds = [evens, odds].map { |array| array.map(&squares) }
p s_evens
p s_odds
```

Outputs:

```
[4, 16, 36, 64]
[1, 9, 25, 49]
```

Suppose we also want to calculate cubes - here is the first attempt using procs:

```ruby
evens = (2..8).step(2).to_a
odds = (1..7).step(2).to_a

squares = proc { |num| num**2 }
cubes = proc { |num| num**3 }

s_evens, s_odds = [evens, odds].map { |array| array.map(&squares) }
c_evens, c_odds = [evens, odds].map { |array| array.map(&cubes) }

p s_evens
p s_odds
p c_evens
p c_odds
```

Outputs:

```
[4, 16, 36, 64]
[1, 9, 25, 49]
[8, 64, 216, 512]
[1, 27, 125, 343]
```

Not part of course, but could also declare a proc that accepts additional arguments, for example a more generic `power` proc that accepts a number and exponent:

```ruby
evens = (2..8).step(2).to_a
odds = (1..7).step(2).to_a

power = proc { |num, exponent| num**exponent }

s_evens, s_odds = [evens, odds].map { |array| array.map { |num| power.call(num, 2) } }
c_evens, c_odds = [evens, odds].map { |array| array.map { |num| power.call(num, 3) } }

p s_evens
p s_odds
p c_evens
p c_odds
```

### Working with Lambdas

Similar to Proc but different in how arguments and `return` keyword are treated.

Lambda validates number of arguments passed to it, throws arg error and halts execution if incorrect.

Proc ignores missing or additional arguments passed to it and continues execution. Proc replaces missing argument with nil value, depending on the type. Eg: String will be replaced with blank character if no value passed.

When lambda encounters `return`, behaves similarly to nested method, it returns execution to calling method.

When `return` statement in proc, it returns control outside the calling method - causes execution to skip over all other statements in enclosing method.

Prefer lambdas over procs if need strict control over the arguments.

Note that they are both objects of the same class `Proc`:

```ruby
proc = proc { puts "This is a Proc" }

# Rubocop: S tyle/Lambda
# my_lambda = lambda { puts "This is a Lambda" }
my_lambda = -> { puts "This is a Lambda" }

p proc.class
# Proc

p my_lambda.class
# Proc
```

See how they're different wrt argument handling - with proc that declares a single arg, can call it with a single param, multiple params or no params and it still works. But this is not the case with lambda, which will expect exactly a single param passed it, otherwise raises `ArgumentError`:

```ruby
# A proc that accepts a single argument
my_proc = proc { |name| puts "Name is #{name}" }

# Call a proc with expected number of args
my_proc.call("John")
# Name is John

# Call a proc with too many args
my_proc.call("John", "Doe")
# Name is John

# Call a proc with no args - replaces `name` with blank character
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
```

Looking at return handling - when the lambda is called, execution is transferred to the block defined for the lambda. This causes execution to jump out of the block, and return control to the next line in the `my_method` method. And this is why the last line `puts ...` is executed:

```ruby
def my_method
  # Create a lambda that simply returns whenever it's called
  my_lambda = -> { return }
  # Call the lambda
  my_lambda.call
  # One more statement - will this run?
  puts "End of method"
end

my_method
# Outputs: End of method
```

Note that lambda behaves similar to nested method wrt `return` handling, however, Rubocop warns to prefer lambda over nested method:

```ruby
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
```

Compare to how proc does return handling - in this case, when `return` is encountered in proc body, execution jumps *outside* of `my_method` to the program that called it, since there's no further code in this example, the program ends. So it never gets to the `puts...` line *inside* of `my_method`:

```ruby
def my_method
  my_proc = proc { return "Exiting my_proc" }
  my_proc.call
  puts "End of method"
end

p my_method
# Output: Exiting my_proc
```

Lesson learned: Careful when using `return` statement inside of a `Proc`, as the behaviour is different as compared to a `lambda`.

### Demo: Unit Conversion with Lambda

Consider the following code that converts meters to various imperial units - there's lots of code duplication such as checking if input is numeric:

```ruby
def convert_to_inches(meters)
  meters * 39.37 if meters.is_a?(Numeric)
end

def convert_to_feet(meters)
  meters * 3.28 if meters.is_a?(Numeric)
end

def convert_to_yards(meters)
  meters * 1.09 if meters.is_a?(Numeric)
end

p convert_to_inches(5)
p convert_to_feet(5)
p convert_to_yards(5)

# Output
# 196.85
# 16.4
# 5.45
```

Here's an improvement using a block to eliminate the duplication of numeric checking:

```ruby
def numeric_check(meters)
  yield(meters) if meters.is_a?(Numeric)
end

# inches
p numeric_check(5) { |meters| meters * 39.37 }

# feet
p numeric_check(5) { |meters| meters * 3.28 }

# yards
p numeric_check(5) { |meters| meters * 1.09 }

# invalid
p numeric_check("foo") { |meters| meters * 12.34 }
```

Improvement using lambdas to name the conversions as per the units they handle:

```ruby
to_inches = ->(meters) { meters * 39.37 }
to_feet = ->(meters) { meters * 3.28 }
to_yards = ->(meters) { meters * 1.09 }

def convert(meters, unit_lambda)
  unit_lambda.call(meters) if meters.is_a?(Numeric)
end

p convert(5, to_inches)
p convert(5, to_feet)
p convert(5, to_yards)

# multiple conversions, ampersand indicates this is a proc/lambda so `call` will be invoked
p [10, 25, 30].map(&to_inches)
```

## Adding Functionality with Mixins

### Modules and Mixins

**Module**

* Grouping of objects under a single name
* Can be shared across classes
* Can consist of constants, methods, classes, and other modules
* Cannot be instantiated
* Do not have a `new` method
* Container of objects or namespace (eg: `Math.PI` - `Math` module exposes constants such as `PI`)
* Namespace is roughly like package in Java - avoid naming conflicts across classes
* Modules can be included in classes (aka mixin) to add behaviour, eg: `Enumerable`
* Module is the superclass of `Class`, therefore every class is also a module.

```ruby
p Class.superclass
# Module

p Enumerable.class
# Modules
```

Let's re-write the unit conversion code as a module - use `module` keyword followed by name of module.

```ruby
module MeterConversion
  # no special keyword in Ruby to declare a constant,
  # as long as first character is uppercase, it's a constant.
  VERSION = 1.0

  # Using `self` keyword tells Ruby we want to call this method
  # on the MeterConversion module.
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

# To access value of a constant in a module, use the `::` resolution operator.
puts MeterConversion::VERSION

# To call a method within a module, use module name, dot, method name
# NOTE: Do NOT use `new` keyword on module, will be undefined
puts MeterConversion.to_inches(5)
puts MeterConversion.to_feet(5)
puts MeterConversion.to_yards(5)

# Outputs
1.0
196.85
16.4
5.45
```

### The Include Statement

After writing a module, will want to use it in a class, this is what `include` keyword is for:

- supports mixin behavior in class - class gets access to all methods and constants defined in the mixin
- mixin modules behave as superclasses, can get a kind of multiple inheritance by including multiple modules in a single class
- `include` statement makes a reference to the named module. If module is in a separate file, must first use `require` keyword to load it, before using `include` statement.

Example:

```ruby
module Printable
  # module defines a single behaviour `print`
  def print(item)
    "#{item} has been successfully printed."
  end
end

class Terminal
  # mixin Printable module
  include Printable
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

terminal = Terminal.new("Term")
# invoke method from module
p terminal.print("Page")
```

Suppose we want to do something every time a module is included?

Example 2: Similar to previous example but this time added a class method `included` in the `Printable` module.

```ruby
module Printable
  def self.included(klass)
    # Define `print_count` attribute on the class this module is being included in
    puts "Printable module has been included in class: #{klass}"
    attr_accessor :print_count
  end

  def print(item)
    # Double pipe followed by equal is: Conditional Assignment Operator
    # If `print_count` has not previously been accessed, value will be set to 0,
    # otherwise, value remains whatever it was.
    @print_count ||= 0

    # Increment print_count
    @print_count += 1

    # Also show the `print_count` attribute in this message
    "#{item} has been successfully printed. Print Count: #{@print_count}"
  end
end

class Terminal
  include Printable
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

terminal1 = Terminal.new("Term")
p terminal1.print("Page")
p terminal1.print("Picture")

terminal2 = Terminal.new("Term")
p terminal2.print("Page")
p terminal2.print("Picture")
```

```
Printable module has been included in class: Terminal
"Page has been successfully printed. Print Count: 1"
"Picture has been successfully printed. Print Count: 2"
"Page has been successfully printed. Print Count: 1"
"Picture has been successfully printed. Print Count: 2"
```

Outputs - note that the `Printable module has been included...` only runs once even though there are two instances of Terminal class created, explanation from ChatGPT:

The `included` method in the `Printable` module runs only once because it is a class method that gets executed when the module is included in a class, not when instances of the class are instantiated. When you include the `Printable` module in the `Terminal` class by calling `include Printable`, the `included` method is executed once, and it adds an instance variable `@print_count` to the `Terminal` class.

When you then create two instances of the Terminal class (terminal1 and terminal2), the initialize method of the Terminal class gets executed separately for each instance, but the included method does not get executed again, since it has already been executed when the Printable module was included in the Terminal class.

This means that both terminal1 and terminal2 have access to the same instance variable @print_count that was added to the Terminal class by the included method. When you call terminal1.print("Page"), for example, it increments the @print_count variable in the Terminal class, and when you call terminal2.print("Page"), it increments the same @print_count variable.

### The Enumerable Mixin

Most widely used mixin in Ruby. Already included in all collection classes (Array, Hash, Set, etc.)

* adds behaviour such as traverse, search, sort, etc. to collection classes
* can also mixin to your own class, in this case, must provide `each` method to return elements of your collection in turn
* if you want sorting capability for your class, must also implement the "spaceship" operator `<=>`

ASIDE: Spaceship operator explanation from ChatGPT:

The "spaceship" operator is a comparison operator in Ruby that returns -1, 0, or 1, depending on whether the left operand is less than, equal to, or greater than the right operand, respectively. The operator is represented by three consecutive characters "<=>", and is sometimes called the "three-way comparison operator". Example:

```ruby
a = 10
b = 5

result = a <=> b

puts result # prints "1", because 10 is greater than 5
```

The spaceship operator is often used in sorting algorithms, where it can be used to compare two elements and determine their relative position in a sorted list. The operator can also be useful for comparing non-numeric values, such as strings or objects, as long as they implement the <=> method to define their comparison behavior.

Example - we'd like to know how many people in a household are below a certain age:

```ruby
class Person
  # include `Comparable` mixin so we can order all the persons by age
  include Comparable
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  # tell Ruby how one person object can be compared with another
  def <=>(other)
    age <=> other.age
  end

  # provide a meaningful representation of the person object whenever its printed to console
  def to_s
    "Name: #{name} and age: #{age}"
  end
end

# this class consists of all the persons in a household
class Household
  include Enumerable
  attr_accessor :people

  def initialize
    @people = []
  end

  def add(person)
    people.push(person)
  end

  # original code was with `&block` but Rubocop flagged Naming/BlockForwarding: Use anonymous block forwarding
  # def each(&block)
  #   people.each(&block)
  # end

  # `each` method acepts a block as a parameter, we pass this block to `each` method of people array
  def each(&)
    people.each(&)
  end
end

# Populate people
john = Person.new("John", 20)
mark = Person.new("Mark", 35)
tim = Person.new("Tim", 10)
jimmy = Person.new("Jimmy", 45)

# Populate households
household1 = Household.new
household1.add(john)
household1.add(mark)

household2 = Household.new
household2.add(tim)
household2.add(jimmy)

# Display info - note the display comes from custom implementation of `to_s` method on Person class
puts "Household 1 members:\n"
puts household1.people
puts "\n"
# Name: John and age: 20
# Name: Mark and age: 35

puts "Household 2 members:\n"
puts household2.people
puts "\n"
# Name: Tim and age: 10
# Name: Jimmy and age: 45

# Now we can use method from Enumerable such as `any?`
puts "Are there any Household 2 members with age > 40\n"
puts(household2.any? { |person| person.age > 40 })
# true

puts "Are there any Household 1 members with age > 50?\n"
puts(household1.any? { |person| person.age > 50 })
# false

# Use Enumerable method `find_all` on household
puts "Who are the Houseold 2 members with age < 20?\n"
age_below20 = (household2.find_all { |person| person.age < 20 })
puts age_below20
# Name: Tim and age: 10
```

Just barely scratched the surface of what `Enumerable` can do, see the Ruby [docs](https://rubyapi.org/3.1/o/enumerable) for more details.

### Overriding Methods
