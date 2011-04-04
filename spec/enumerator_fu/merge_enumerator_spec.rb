require "spec_helper"
require "enumerator_fu/merge_enumerator"

describe EnumeratorFu::MergeEnumerator do

  include EnumeratorFu
  
  context "without a block" do

    before do
      @array1 = [1,3,6]
      @array2 = [2,4,7]
      @array3 = [5,8]
      @merge_enum = MergeEnumerator.new([@array1, @array2, @array3].map(&:to_enum))
    end

    it "merges multiple Enumerators" do
      @merge_enum.to_a.should == [1,2,3,4,5,6,7,8]
    end

  end
  
end