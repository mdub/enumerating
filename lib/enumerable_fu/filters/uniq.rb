require 'enumerable_fu/filters/abstract'
require 'set'

module EnumerableFu
  module Filters

    class Uniq < Abstract

      def initialize(*args)
        super
        @seen = Set.new
      end

      def each
        return to_enum unless block_given?
        source.each do |item|
          yield(item) if @seen.add?(transform(item))
        end
      end

    end

  end
end
