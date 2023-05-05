# frozen_string_literal: false

user_entered = {}

print 'Напишите числом день: '
user_entered['day'] = gets.chomp.to_i

print 'Напишите числом месяц: '
user_entered['month'] = gets.chomp.to_i

print 'Напиште числом год: '
user_entered['year'] = gets.chomp.to_i

def leap_year?(year)
  return true if (year % 4).zero? && (year % 400).zero?
  return false if (year % 100).zero?
end

def user(day, month, year)
  days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  days_in_months[1] = 29 if leap_year?(year)

  if month > 1
    day + days_in_months.take(month - 1).sum
  else
    day
  end
end

if leap_year?(user_entered['year'])
  print 'Год был високосным: '
else
  print 'Год был не високосный: '
end

puts user(user_entered['day'], user_entered['month'], user_entered['year'])
