require 'set'

class UniqEnumerator
  
  def initialize(base_enum)
    @base_enum = base_enum.to_enum
  end
  
  include Enumerable
  
  def each
    @base_enum.each do |value|
      yield value unless seen?(value)
    end
  end

  private
  
  def seen?(value)
    @seen ||= Set.new
    previously_seen = @seen.member?(value)
    @seen << value
    previously_seen
  end
  
end
