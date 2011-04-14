module EnumerableFu

  class Zipper

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

class << Enumerable

  def zipping(*enumerables)
    EnumerableFu::Zipper.new(enumerables)
  end

end
