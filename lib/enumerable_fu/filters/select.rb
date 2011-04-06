module EnumerableFu
  module Filters
    
    class Select

      include Enumerable

      def initialize(source, &selector)
        unless selector
          raise ArgumentError, "block expected"
        end
        @source = source
        @selector = selector
      end

      def each
        return to_enum unless block_given?
        @source.each do |item|
          yield(item) if @selector.call(item)
        end
      end

    end
    
  end
end
