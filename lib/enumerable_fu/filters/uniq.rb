require 'set'

module EnumerableFu
  module Filters

    class Uniq

      include Enumerable

      def initialize(source, &distinctor)
        @source = source
        @distinctor = distinctor
        @seen = Set.new
      end

      def each
        return to_enum unless block_given?
        @source.each do |item|
          item_key = distinguish(item)
          yield(item) if @seen.add?(item_key)
        end
      end

      private

      def distinguish(item)
        return item unless @distinctor
        @distinctor.call(item)
      end

    end

  end
end
