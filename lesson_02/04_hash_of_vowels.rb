# Заполнить хеш гласными буквами, где значением будет являтся
# порядковый номер буквы в алфавите (a - 1).

vowels = %w(a e i o u y)
vowels_with_numbers =
('a'..'z').each.with_index(1).with_object({}) do |(letter, index), hash|
  hash[letter] = index if vowels.include?(letter)
end

puts vowels_with_numbers
