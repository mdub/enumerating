require 'benchmark'

$: << File.expand_path("../../lib", __FILE__)

require "enumerable_fu/core_ext/enumerable"

array = (1..100000).to_a

Benchmark.bmbm do |bm|
  bm.report("conventional") do
    array.select { |x| x.even? }.collect { |x| x*x }
  end
  bm.report("enumerable_fu") do
    array.selecting { |x| x.even? }.collecting { |x| x*x }.to_a
  end
end
