require "spec_helper"
require "enumerable_fu"

describe Enumerable, "#collecting" do

  it "transforms items" do
    @collect = [1,2,3].collecting { |x| x * 2 }
    @collect.to_a.should == [2,4,6]
  end

end
