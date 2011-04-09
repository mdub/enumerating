require "spec_helper"
require "enumerable_fu/filters/collect"

describe EnumerableFu::Filters::Collect do

  it "transforms items" do
    @collect = EnumerableFu::Filters::Collect.new([1,2,3]) { |x| x * 2 }
    @collect.to_a.should == [2,4,6]
  end

end
