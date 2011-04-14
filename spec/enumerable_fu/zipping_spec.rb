require "spec_helper"

describe Enumerable, :needs_enumerators => true do

  describe "#zipping" do

    it "zips together multiple Enumerables" do
      @array1 = [1,3,6]
      @array2 = [2,4,7]
      @array3 = [5,8]
      @zip = Enumerable.zipping(@array1, @array2, @array3)
      @zip.to_a.should == [[1,2,5], [3,4,8], [6,7,nil]]
    end

    it "is lazy" do
      @zip = Enumerable.zipping(%w(a b c), [1,2].with_time_bomb)
      @zip.take(2).should == [["a", 1], ["b", 2]]
    end

  end

end
