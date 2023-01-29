i = 0
lang = "Ruby
Java
Pyton
C
"

lang.each_line { |line| print "#{i += 1} #{line}" }
