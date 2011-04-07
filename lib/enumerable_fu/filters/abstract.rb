module EnumerableFu
  module Filters
    
    class Abstract

      include Enumerable

      def initialize(source, &transformer)
        @source = source
        @transformer = transformer
      end

      attr_reader :source
      attr_reader :transformer
      
      private
      
      def transform(item)
        if @transformer
          @transformer.call(item)
        else
          item
        end
      end
      
    end
    
  end
end
