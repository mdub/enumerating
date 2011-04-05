module EnumeratorFu

  class Zip

    def initialize(enumerators)
      @enumerators = enumerators.map(&:to_enum)
    end

    include Enumerable

    def each
      while true
        chunk = @enumerators.map do |enumerator|
          begin
            enumerator.next
          rescue StopIteration
            nil
          end
        end
        break if chunk.all?(&:nil?)
        yield chunk
      end
    end

  end

end
