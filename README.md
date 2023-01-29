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

