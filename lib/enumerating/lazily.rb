module Enumerable

  def lazily
    Enumerating::LazyProxy.new(self)
  end

end

module Enumerating

  module LazyEnumerable

    include Enumerable

    def lazy
      self
    end

    def force
      to_a
    end

    def collect
      LazyFilter.new do |yielder|
        each do |element|
          yielder.call yield(element)
        end
      end
    end

    def select
      LazyFilter.new do |yielder|
        each do |element|
          yielder.call(element) if yield(element)
        end
      end
    end

    def reject
      LazyFilter.new do |yielder|
        each do |element|
          yielder.call(element) unless yield(element)
        end
      end
    end

  end

  class LazyProxy

    include LazyEnumerable

    def initialize(source)
      @source = source
    end

    def each(&block)
      return to_enum unless block
      @source.each(&block)
    end

  end

  class LazyFilter

    include LazyEnumerable

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
