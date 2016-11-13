# Сумма покупок
# Пользователь вводит поочередно название товара,
# цену за единицу и кол-во купленного товара (может быть нецелым числом).
# Пользователь может ввести произвольное кол-во товаров до тех пор,
# пока не введет "стоп" в качестве названия товара.
# На основе введенных данных требуетеся:
# Заполнить и вывести на экран хеш, ключами которого являются названия товаров,
# а значением - вложенный хеш, содержащий цену за единицу товара и
# кол-во купленного товара. Также вывести итоговую сумму за каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

require 'bigdecimal'

list = {}
loop do
  puts 'Введите название товара или "стоп" чтобы закончить'
  name = gets.chomp.to_sym

  break if name == :стоп

  puts 'Введите цену за единицу товара'
  price = BigDecimal.new(gets.chomp, 2)

  puts 'Введите колличетво купленного товара'
  quantity = gets.to_f

  list[name] ||= []
  list[name] << { price: price, quantity: quantity }
end

list.each do |name, buy|
  buy.each { |h| h[:sum] = h[:price] * h[:quantity] }
end
total_sum = list.reduce(0) do |sum, (_name, buy)|
  sum += buy.reduce(0) { |sum, h| sum += h[:sum] }
end


puts list

list.each do |name, buy|
  buy.each do |h|
    puts "#{name} цена: #{sprintf("%.2f", h[:price])} "\
                 "колличество: #{h[:quantity]} "\
                 "стоимость: #{sprintf("%.2f", h[:sum])}"
  end
end
puts "Итоговая сумма #{sprintf("%.2f", total_sum)}"
