p 'a, b, c'
a = gets.chomp.to_f
b = gets.chomp.to_f
c = gets.chomp.to_f

def triangle(a, b, c)
  arr = [a, b, c]
  if arr.min == 0
    p 'bad values!'
    return
  end

  if arr.uniq.size == 1
    p 'равносторонний'
  else
    hypotenuse = arr.sort!
    kat1 = arr[0]
    kat2 = arr[1]
    gip = arr[2]
    if kat1 == kat2
      p 'равнобедренный'
    elsif arr[2]**2 == arr[0]**2 + arr[1]**2
      p 'прямоугольный'
    else
      p 'разносторонний'
    end
  end
end

triangle(a, b, c)
