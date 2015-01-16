class Filter
  attr :filter

  def initialize(&block)
    @filter = block
  end

  def call(x)
    @filter.call(x)
  end

  def |(other)
    Filter.new { |x| call x or other.call x }
  end

  def &(other)
    Filter.new { |x| call x and other.call x }
  end
end

class TypeFilter < Filter
  def initialize(type)
    case type
    when :integer then super() { |x| x.integer? }
    when :complex then super() { |x| not x.real? }
    when :real    then super() { |x| x.real? and not x.integer? }
    end
  end
end

class SignFilter < Filter
  def initialize(sign_type)
    case sign_type
    when :positive     then super() { |x| x > 0 }
    when :negative     then super() { |x| x < 0 }
    when :non_positive then super() { |x| x <= 0 }
    when :non_negative then super() { |x| x >= 0 }
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

  def each(&block)
    @data.each(&block)
  end
end