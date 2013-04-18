require 'enumerating/filtering'
require 'enumerating/prefetching'

module Enumerable

  def threading(max_threads, &block)
    collecting do |item|
      Thread.new { block.call(item) }
    end.prefetching(max_threads - 1).collecting do |thread|
      thread.join; thread.value
    end
  end

end
