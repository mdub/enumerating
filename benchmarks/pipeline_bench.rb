require 'benchmark'

$: << File.expand_path("../../lib", __FILE__)

require "enumerable_fu/core_ext/enumerable"
require "enumerable_lz"

array = (1..100000).to_a

Benchmark.bmbm do |bm|
  bm.report("conventional") do
    @control = array.select { |x| x.even? }.collect { |x| x*x }
  end
  bm.report("enumerable_fu") do
    @fu = array.selecting { |x| x.even? }.collecting { |x| x*x }.to_a
  end
  bm.report("enumerable_lz") do
    @lz = array.filter { |x| x.even? }.transform { |x| x*x }.to_a
  end
end

puts "enumerable_fu is busted" unless @fu == @control
puts "enumerable_lz is busted" unless @lz == @control
