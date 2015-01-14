class Proc
  def &(other)
    ->( *args) { self[ *args] && other[ *args] }
  end

  def |(other)
    ->( *args) { self[ *args] || other[ *args] }
  end
end


class Filter
  attr :filter

  def initialize(&block)
    @filter = block
  end

  def call(x)
    @filter.call(x)
  end

  def |(other)
    @filter = @filter | other.filter
    self
  end

  def &(other)
    @filter = @filter & other.filter
    self
  end
end

class TypeFilter < Filter
  def initialize(type)
    case type
    when :integer then @filter = ->(x){ x.is_a?(Integer) }
    when :real then @filter = ->(x){ x.is_a?(Float) || x.is_a?(Rational) }
    when :complex then @filter = ->(x){ x.is_a?(Complex) }
    end
  end
end

class SignFilter < Filter
  def initialize(sign_type)
    case sign_type
    when :positive then @filter = ->(x){ x > 0 }
    when :non_positive then @filter = ->(x){ x <= 0 }
    when :negative then @filter = ->(x){ x < 0 }
    when :non_negative then @filter = ->(x){ x >= 0 }
    end
  end
end

class NumberSet
  include Enumerable

  def initialize
    @data = []
  end

  def <<(new_element)
    @data << new_element unless @data.include? new_element
    self
  end

  def [](filter)
    numbers = NumberSet.new
    each { | x | numbers << x if filter.call(x) }
    numbers
  end

  def size
    @data.size
  end

  def empty?
    @data.size == 0
  end

  def each
    if block_given?
      @data.each { |x| yield x}
	else
	  result = @data.to_enum
	end
  end
end