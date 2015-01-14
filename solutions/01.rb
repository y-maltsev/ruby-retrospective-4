def fibonacci(index)
  if index < 3
    1
  else
    fibonacci(index - 1) + fibonacci(index - 2)
  end
end

def lucas(index)
  if index < 3
    index == 1 ? 2 : 1
  else
    lucas(index - 1) + lucas(index - 2)
  end
end

def series(type, index)
  case type
  when 'fibonacci' then fibonacci(index)
  when 'lucas' then lucas(index)
  when 'summed' then lucas(index) + fibonacci(index)
  end
end