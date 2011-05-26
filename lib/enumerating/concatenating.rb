
module Enumerating
  
  class Concatenator
    
    include Enumerable
    
    def initialize(enumerables)
      @enumerables = enumerables
    end
    
    def each(&block)
      @enumerables.each do |enumerable|
        enumerable.each(&block)
      end
    end
    
  end

end

class << Enumerating

  def concatenating(*enumerables)
    Enumerating::Concatenator.new(enumerables)
  end

end