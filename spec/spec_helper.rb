require "rubygems"

require 'rspec'

RSpec.configure do |config|


end

class FailingEnumerable

  include Enumerable

  def initialize(source)
    @source = source
  end

  def each(&block)
    @source.each(&block)
    raise "hell"
  end

end
