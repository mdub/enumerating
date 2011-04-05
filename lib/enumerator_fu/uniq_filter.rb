require 'set'

module EnumeratorFu

  class UniqFilter

    include Enumerable

    def initialize(enumerator, &distinctor)
      @enumerator = enumerator
      @distinctor = distinctor
      @seen = Set.new
    end

    def each
      return to_enum unless block_given?
      @enumerator.each do |item|
        item_key = distinguish(item)
        yield(item) if @seen.add?(item_key)
      end
    end

    private

    def distinguish(item)
      return item unless @distinctor
      @distinctor.call(item)
    end

  end

end
