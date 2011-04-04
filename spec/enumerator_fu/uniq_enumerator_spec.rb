require "spec_helper"
require "enumerator_fu/uniq_enumerator"

describe EnumeratorFu::UniqEnumerator do

  include EnumeratorFu
  
  context "without a block" do

    before do
      @array = [1,3,2,4,3,5,4,6]
      @uniq_enum = UniqEnumerator.new(@array.to_enum)
    end

    it "removes duplicates" do
      @uniq_enum.to_a.should == [1,3,2,4,5,6]
    end

  end

  context "with a block" do

    before do
      @array = %w(A1 A2 B1 A3 C1 B2 C2)
      @uniq_enum = UniqEnumerator.new(@array.to_enum) { |s| s[0,1] }
    end

    it "uses the block to derive identity" do
      @uniq_enum.to_a.should == %w(A1 B1 C1)
    end

  end
  
end