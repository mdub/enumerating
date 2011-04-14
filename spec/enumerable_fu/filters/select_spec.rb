require "spec_helper"

describe Enumerable, "#selecting" do

  it "excludes items that don't pass the predicate" do
    (1..6).selecting { |x| x.even? }.to_a.should == [2,4,6]
  end

  it "is lazy" do
    (1..6).with_time_bomb.selecting { |x| x.even? }.first == 2
  end

end