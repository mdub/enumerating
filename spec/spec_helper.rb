require "rubygems"

require 'rspec'

RSpec.configure do |config|
  unless defined?(::Enumerator)
    config.filter_run_excluding :needs_enumerators => true
  end
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
