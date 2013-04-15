require 'enumerating/prefetching'

module Enumerating

  class ThreadStarter

    include Enumerable

    def initialize(source, block)
      @source = source
      @block = block
    end

    def each
      @source.each do |source_item|
        thread = Thread.new do
          @block.call(source_item)
        end
        yield thread
      end
    end

  end

  class ThreadJoiner

    include Enumerable

    def initialize(threads)
      @threads = threads
    end

    def each
      @threads.each do |thread|
        thread.join
        yield thread.value
      end
    end

  end

end

module Enumerable

  def threading(max_threads, &block)
    threads = Enumerating::ThreadStarter.new(self, block)
    Enumerating::ThreadJoiner.new(threads.prefetching(max_threads - 1))
  end

end
