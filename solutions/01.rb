def sequence(first, second, index)
  (index - 1).times do
    second = first + second
    first = second - first
  end
  first
end


def series(type, index)
  case type
  when 'fibonacci' then sequence(1, 1, index)
  when 'lucas' then sequence(2, 1, index)
  when 'summed' then  sequence(1, 1, index) + sequence(2, 1, index)
  end
end