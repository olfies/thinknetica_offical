# frozen_string_literal: false

puts 'Какое основание у вашего треугольника?'
base = gets.chomp

puts 'Какая высота у вашего треугольника?'
height = gets.chomp

puts (0.5 * base.to_i * height.to_i).to_s
