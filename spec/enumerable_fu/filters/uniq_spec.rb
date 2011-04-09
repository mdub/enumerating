require "spec_helper"
require "enumerable_fu/filters/uniq"

describe EnumerableFu::Filters::Uniq do

  context "without a block" do

    before do
      @array = [1,3,2,4,3,5,4,6]
      @uniq = @array.deduping
    end

    it "removes duplicates" do
      @uniq.to_a.should == [1,3,2,4,5,6]
    end

  end

  context "with a block" do

    before do
      @array = %w(A1 A2 B1 A3 C1 B2 C2)
      @uniq = @array.deduping { |s| s[0,1] }
    end

    it "uses the block to derive identity" do
      @uniq.to_a.should == %w(A1 B1 C1)
    end

  end
  
  it "is lazy" do
    @uniq = [1,2,3].with_time_bomb.deduping
    @uniq.take(3).should == [1,2,3]
    lambda do
      @uniq.take(4)
    end.should raise_error(Boom)
  end
  
end
