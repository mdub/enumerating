module Enumerating

  class Prefetcher

    include Enumerable

    def initialize(source, buffer_size)
      @source = source.to_enum
      @buffer_size = buffer_size
    end

    def each
      buffered_elements = []
      i = 0
      @source.each do |element|
        slot = i % @buffer_size
        if i >= @buffer_size
          yield buffered_elements[slot]
        end
        buffered_elements[slot] = element
        i += 1
      end
      buffered_elements.size.times do
        slot = i % buffered_elements.size
        yield buffered_elements[slot]
        i += 1
      end
    end

  end

end

module Enumerable

  def prefetching(size)
    Enumerating::Prefetcher.new(self, size)
  end

end
