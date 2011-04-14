require "rubygems"

require 'rspec'

RSpec.configure do |config|
  unless defined?(::Enumerator)
    config.filter_run_excluding :needs_enumerators => true
  end
end

class Boom < StandardError; end

class WithTimeBomb

  include Enumerable

  def initialize(source)
    @source = source
  end

  def each(&block)
    @source.each(&block)
    raise Boom
  end

end

module Enumerable
  
  # extend an Enumerable to throw an exception after last element
  def with_time_bomb
    WithTimeBomb.new(self)
  end
  
end

require "enumerable_fu"
