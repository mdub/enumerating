require 'benchmark'

$: << File.expand_path("../../lib", __FILE__)

require "lazing"
module Enumerable
  alias :lazing_select :selecting
  alias :lazing_collect :collecting
end

require "enumerable_fu"

require 'facets'

array = (1..100000).to_a

# Test scenario:
#  - filter out even numbers
#  - square them
#  - grab the first thousand

printf "%-30s", "IMPLEMENTATION"
printf "%12s", "take(10)"
printf "%12s", "take(100)"
printf "%12s", "take(1000)"
printf "%12s", "to_a"
puts ""

def benchmark(description, control_result = nil)
  result = nil
  printf "%-30s", description
  printf "%12.5f", Benchmark.realtime { yield.take(10).to_a }
  printf "%12.5f", Benchmark.realtime { yield.take(100).to_a }
  printf "%12.5f", Benchmark.realtime { result = yield.take(1000).to_a }
  printf "%12.5f", Benchmark.realtime { yield.to_a }
  puts ""
  unless control_result.nil? || result == control_result
    raise "unexpected result from '#{description}'"
  end
  result
end

@control = benchmark "conventional" do
  array.select { |x| x.even? }.collect { |x| x*x }
end

benchmark "enumerable_fu", @control do 
  array.selecting { |x| x.even? }.collecting { |x| x*x }
end

benchmark "lazing", @control do
  array.lazing_select { |x| x.even? }.lazing_collect { |x| x*x }
end

benchmark "facets Enumerable#defer", @control do
  array.defer.select { |x| x.even? }.collect { |x| x*x }
end
