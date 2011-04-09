require 'enumerable_fu/filters/abstract'

module EnumerableFu
  module Filters
    
    class Reject < Abstract

      def each
        return to_enum unless block_given?
        source.each do |item|
          yield(item) unless transform(item)
        end
      end

    end
    
  end
end

module Enumerable
  
  def rejecting(&block)
    EnumerableFu::Filters::Reject.new(self, &block)
  end
  
end