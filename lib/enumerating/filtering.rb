require 'set'

module Enumerating

  class Filter

    include Enumerable

    def initialize(&generator)
      @generator = generator
    end

    def each
      return to_enum unless block_given?
      yielder = proc { |x| yield x }
      @generator.call(yielder)
    end

  end

end

module Enumerable
  
  def collecting
    Enumerating::Filter.new do |output|
      each do |element|
        output.call yield(element)
      end
    end
  end
  
  def selecting
    Enumerating::Filter.new do |output|
      each do |element|
        output.call(element) if yield(element)
      end
    end
  end
  
  def rejecting
    Enumerating::Filter.new do |output|
      each do |element|
        output.call(element) unless yield(element)
      end
    end
  end
  
  def uniqing
    Enumerating::Filter.new do |output|
      seen = Set.new
      each do |element|
        output.call(element) if seen.add?(element)
      end
    end
  end

  def uniqing_by
    Enumerating::Filter.new do |output|
      seen = Set.new
      each do |element|
        output.call(element) if seen.add?(yield element)
      end
    end
  end
  
end
