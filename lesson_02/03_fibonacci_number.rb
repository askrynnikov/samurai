fibonacci_numbers = []
LIMIT = 100

loop do
  fibonacci =
    case fibonacci_numbers.size
    when 0
      0
    when 1
      1
    else
      fibonacci_numbers[-1]+fibonacci_numbers[-2]
    end
  break if fibonacci > LIMIT
  fibonacci_numbers << fibonacci
end

puts fibonacci_numbers