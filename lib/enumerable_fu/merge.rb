module EnumerableFu
  
  class Merge
    
    def initialize(enumerators, &transformer)
      @enumerators = enumerators.map(&:to_enum)
      @transformer = transformer
    end
    
    include Enumerable
    
    def each(&block)
      return to_enum unless block_given?
      Generator.new(@enumerators.dup, @transformer).each(&block)
    end
    
    class Generator
      
      def initialize(enumerators, transformer)
        @enumerators = enumerators
        @transformer = transformer
      end
      
      def each
        while true do
          discard_empty_enumerators
          break if @enumerators.empty?
          yield next_enumerator.next
        end
      end

      private
      
      def discard_empty_enumerators
        @enumerators.delete_if do |e|
          begin
            e.peek
            false
          rescue StopIteration
            true
          end
        end
      end

      def next_enumerator
        @enumerators.min_by { |enumerator| transform(enumerator.peek) }
      end

      def transform(item)
        return item unless @transformer
        @transformer.call(item)
      end
      
    end

  end
  
end
