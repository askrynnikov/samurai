puts 'Ваше имя?'
name = gets.chomp.capitalize

puts 'Ваш рост в сантиметрах?'
height = gets.to_i

ideal_weight = height - 110

result =
  if ideal_weight >= 0
    "#{name}, ваш идеальный вес #{ideal_weight} кг."
  else
    'Ваш вес уже оптимальный.'
  end

puts result
