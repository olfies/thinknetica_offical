# frozen_string_literal: false

puts 'Привет, как тебя зовут?'
name = gets.chomp

puts "#{name}, какой у тебя рост?"
height = gets.chomp

if (height.to_i - 110).positive?
  puts "#{name}, твой идеальный вес #{height.to_i - 110}"
else
  puts 'Ваш вес уже оптимальный'
end
