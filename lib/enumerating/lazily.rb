module Enumerable

  def lazily
    Lazily.new do |output|
      each do |element|
        output.call(element)
      end
    end
  end

  class Lazily

    include Enumerable

    def initialize(&generator)
      @generator = generator
    end

    def each
      return to_enum unless block_given?
      yielder = proc { |x| yield x }
      @generator.call(yielder)
    end

    def lazy
      self
    end

    def force
      to_a
    end

    def collect
      Lazily.new do |output|
        each do |element|
          output.call yield(element)
        end
      end
    end

    def select
      Lazily.new do |output|
        each do |element|
          output.call(element) if yield(element)
        end
      end
    end

    alias finding_all selecting

    def reject
      Lazily.new do |output|
        each do |element|
          output.call(element) unless yield(element)
        end
      end
    end

  end

end
