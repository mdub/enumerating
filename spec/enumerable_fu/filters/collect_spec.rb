require "spec_helper"
require "enumerable_fu/filters/collect"

describe EnumerableFu::Filters::Collect do

  include EnumerableFu::Filters

  it "transforms items" do
    @collect = Collect.new([1,2,3]) { |x| x * 2 }
    @collect.to_a.should == [2,4,6]
  end

end
