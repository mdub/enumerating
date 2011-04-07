require 'enumerable_fu/filters'

module Enumerable
  
  def collecting(&block)
    EnumerableFu::Filters::Collect.new(self, &block)
  end

  def rejecting(&block)
    EnumerableFu::Filters::Reject.new(self, &block)
  end

  def selecting(&block)
    EnumerableFu::Filters::Select.new(self, &block)
  end

  def uniqing(&block)
    EnumerableFu::Filters::Uniq.new(self, &block)
  end
  
end
