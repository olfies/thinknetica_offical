# frozen_string_literal: false

puts 'Введите 3 коффицента'
a = gets.chomp.to_f
b = gets.chomp.to_f
c = gets.chomp.to_f
def result(a, b, c)
  dis = b**2 - 4 * a * c
  if dis.negative?
    "Дискриминант #{dis}.Корней нет"
  elsif dis.zero?
    "Дискриминант #{dis}.Корни равны"
  else
    "Дискриминант #{dis}. #{-b - Math.sqrt(dis) / a * 2} и #{-b + Math.sqrt(dis) / a * 2}"
  end
end
puts result(a, b, c)
