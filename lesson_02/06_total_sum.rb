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

list = {}
loop do
  puts 'Введите название товара или "стоп" чтобы закончить'
  name = gets.chomp
  break if name == 'стоп'

  puts 'Введите цену за единицу товара'
  price = gets.to_f

  puts 'Введите колличетво купленного товара'
  quantity = gets.to_f

  list[name] =
    if list.key?(name)
      { price: (list[name][:quantity] * list[name][:price] +
        quantity * price) / (list[name][:quantity] + quantity),
        quantity: list[name][:quantity] + quantity }
    else
      { price: price, quantity: quantity }
    end
end

list.each do |name, buy|
  list[name][:sum] = (buy[:price] * buy[:quantity]).round(2)
end
total_sum = list.reduce(0) { |sum, (_name, buy)| sum += buy[:sum] }


list.each do |name, buy|
  puts "#{name} цена: #{buy[:price].round(2)} "\
               "колличество: #{buy[:quantity]} "\
               "стоимость: #{sprintf("%.2f", buy[:sum])}"
end
puts "Итоговая сумма #{sprintf("%.2f", total_sum)}"
