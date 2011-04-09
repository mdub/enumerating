require "spec_helper"
require "enumerable_fu/filters/reject"

describe EnumerableFu::Filters::Reject do

  it "excludes items that do pass the predicate" do
    EnumerableFu::Filters::Reject.new(1..6) { |x| x.even? }.to_a.should == [1,3,5]
  end

end