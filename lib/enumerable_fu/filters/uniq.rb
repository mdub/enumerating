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

module Enumerable
  
  def uniqing
    EnumerableFu::Filters::Uniq.new(self)
  end

  alias :deduping :uniqing

  def uniqing_by(&block)
    EnumerableFu::Filters::Uniq.new(self, &block)
  end
  
  alias :deduping_by :uniqing_by
  
end
