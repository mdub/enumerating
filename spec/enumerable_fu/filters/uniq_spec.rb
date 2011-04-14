require "spec_helper"

describe EnumerableFu, "#uniqing" do

  describe "#uniqing" do

    it "removes duplicates" do
      [1,3,2,4,3,5,4,6].uniqing.to_a.should == [1,3,2,4,5,6]
    end

    it "is lazy" do
      [1,2,3].with_time_bomb.uniqing.first.should == 1
    end

  end

  describe "#uniqing_by" do

    it "uses the block to derive identity" do
      @array = %w(A1 A2 B1 A3 C1 B2 C2)
      @array.uniqing_by { |s| s[0,1] }.to_a.should == %w(A1 B1 C1)
    end

  end

end
