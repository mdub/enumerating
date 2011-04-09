require "spec_helper"
require "enumerable_fu/filters/select"

describe EnumerableFu::Filters::Select do

  it "excludes items that don't pass the predicate" do
    @select = (1..10).selecting { |x| x.even? }
    @select.take(3).should == [2,4,6]
  end

  it "is lazy" do
    @select = FailingEnumerable.new([1,2,3]).selecting { |x| x.even? }
    @select.take(1)
    lambda do
      @select.take(2)
    end.should raise_error(EndOfTheLine)
  end

end