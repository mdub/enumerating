require "rubygems"

require 'rspec'

RSpec.configure do |config|


end

class EndOfTheLine < StandardError; end

class FailingEnumerable

  include Enumerable

  def initialize(source)
    @source = source
  end

  def each(&block)
    @source.each(&block)
    raise EndOfTheLine
  end

end
