require 'set'

module EnumeratorFu

  class UniqEnumerator

    def initialize(base_enum, &transform)
      @base_enum = base_enum.to_enum
      @transform = transform
    end

    include Enumerable

    def each
      @base_enum.each do |value|
        yield value unless seen?(value)
      end
    end

    private

    def seen?(value)
      transformed_value = if @transform
        @transform.call(value)
      else
        value
      end
      @seen ||= Set.new
      previously_seen = @seen.member?(transformed_value)
      @seen << transformed_value
      previously_seen
    end

  end

end
