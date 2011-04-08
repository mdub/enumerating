require 'benchmark'

$: << File.expand_path("../../lib", __FILE__)

require "enumerable_fu/core_ext/enumerable"
require "enumerable_lz"

array = (1..100000).to_a

# Test scenario:
#  - filter out even numbers
#  - square them
#  - grab the first thousand

Benchmark.bmbm do |bm|
  bm.report("enumerable_fu") do
    @fu = array.selecting { |x| x.even? }.collecting { |x| x*x }.take(1000)
  end
  bm.report("enumerable_lz") do
    @lz = array.filter { |x| x.even? }.transform { |x| x*x }.take(1000)
  end
  bm.report("conventional") do
    @control = array.select { |x| x.even? }.collect { |x| x*x }.take(1000)
  end
end
