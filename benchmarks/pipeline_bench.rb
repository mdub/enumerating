require 'benchmark'

$: << File.expand_path("../../lib", __FILE__)

require "enumerable_lz"

require "lazing"
module Enumerable
  alias :lazing_select :selecting
  alias :lazing_collect :collecting
end

require "enumerable_fu/core_ext/enumerable"

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
  bm.report("lazing") do
    @lz = array.lazing_select { |x| x.even? }.lazing_collect { |x| x*x }.take(1000)
  end
  bm.report("conventional") do
    @control = array.select { |x| x.even? }.collect { |x| x*x }.take(1000)
  end
end
