require 'enumerable_fu/filters/abstract'

module EnumerableFu
  module Filters
    
    class Select < Abstract

      def each
        return to_enum unless block_given?
        source.each do |item|
          yield(item) if transform(item)
        end
      end

    end
    
  end
end
