fib_number = [0, 1]
while (new_number = fib_number.last(2).sum) <= 100
  fib_number << new_number
end

puts fib_number.to_s
