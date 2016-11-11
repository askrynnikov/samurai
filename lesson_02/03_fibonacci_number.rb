LIMIT = 100

fibonacci_numbers = [0, 1]
loop do
  fibonacci = fibonacci_numbers[-1] + fibonacci_numbers[-2]
  break if fibonacci > LIMIT
  fibonacci_numbers << fibonacci
end

puts fibonacci_numbers
