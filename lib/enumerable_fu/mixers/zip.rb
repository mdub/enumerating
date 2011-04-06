module EnumerableFu
  module Mixers

    class Zip

      include Enumerable

      def initialize(enumerables)
        @enumerables = enumerables
      end

      def each
        enumerators = @enumerables.map(&:to_enum)
        while true
          chunk = enumerators.map do |enumerator|
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
end
