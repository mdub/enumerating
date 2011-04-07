require 'enumerable_fu/filters/abstract'

module EnumerableFu
  module Filters
    
    class Collect < Abstract

      def each
        return to_enum unless block_given?
        source.each do |item|
          yield transform(item)
        end
      end

    end
    
  end
end
