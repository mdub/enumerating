require "spec_helper"

describe Enumerable, "#collecting" do

  it "transforms items" do
    [1,2,3].collecting { |x| x * 2 }.to_a.should == [2,4,6]
  end
  
  it "is lazy" do
    [1,2,3].with_time_bomb.collecting { |x| x * 2 }.first.should == 2
  end

end
