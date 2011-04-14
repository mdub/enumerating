require "spec_helper"

describe EnumerableFu::Filters::Uniq do

  context "without a block" do

    it "removes duplicates" do
      [1,3,2,4,3,5,4,6].deduping.to_a.should == [1,3,2,4,5,6]
    end

  end

  context "with a block" do

    it "uses the block to derive identity" do
      @array = %w(A1 A2 B1 A3 C1 B2 C2)
      @array.deduping { |s| s[0,1] }.to_a.should == %w(A1 B1 C1)
    end

  end
  
  it "is lazy" do
    [1,2,3].with_time_bomb.deduping.first.should == 1
  end
  
end
