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

  class << self

    def threading(source, max_threads, &block)
      threads = ThreadStarter.new(source, block)
      prefetched_threads = Prefetcher.new(threads, max_threads - 1)
      Enumerating::ThreadJoiner.new(prefetched_threads)
    end

  end

end

module Enumerable

  def threading(max_threads, &block)
    Enumerating.threading(self, max_threads, &block)
  end

end
