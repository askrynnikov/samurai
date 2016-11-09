puts 'Проверяем является ли треугольник прямоугольным'

puts 'Одной строкой введите длины трех сторон треугольника:'

side_1, side_2, side_3 = *gets.chomp.split(/[^\p{Digit}\.]+/).map(&:to_f)

if side_1 > side_2 && side_1 > side_3
  c = side_1; a = side_2; b = side_3
elsif side_2 > side_1 && side_2 > side_3
  c = side_2; a = side_1; b = side_3
else
  c = side_3; a = side_1; b = side_2
end

result =
  if c**2 == a**2 + b**2
    if a == b
      'прямоугольный и равнобедренный'
    else
      'прямоугольный'
    end
  elsif a == b && b == c && a == c
    'равносторонний'
  elsif a == b || b == c || a == c
    'равнобедренный'
  else
    'не равносторонний, не прямоугольный, не равнобедренный'
  end

puts "Треугольник #{result}."
