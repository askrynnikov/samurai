# Заполнить хеш гласными буквами, где значением будет являтся
# порядковый номер буквы в алфавите (a - 1).

vowels = %w(a e i o u y)
alphabet = [*('a'..'z')]
vowels_with_numbers = vowels.each_with_object({}) do |letter, mem|
  mem[letter] = alphabet.index(letter) + 1
end

puts vowels_with_numbers
