module EnumeratorFu
  
  class MergeEnumerator
    
    def initialize(source_enumerators)
      @source_enumerators = source_enumerators
    end
    
    include Enumerable
    
    def each
      live_enumerators = @source_enumerators
      while true
        
        # discard empty Enumerators
        live_enumerators.delete_if do |e|
          begin
            e.peek
            false
          rescue StopIteration
            true
          end
        end

        # terminate if none remain
        break if live_enumerators.empty?
        
        # yield the next value
        next_enumerator = live_enumerators.min_by { |e| e.peek }
        yield next_enumerator.next
        
      end
    end
    
  end
  
end