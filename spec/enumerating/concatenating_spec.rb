require "spec_helper"

describe Enumerating do

  describe ".concatenating" do
    
    it "concatenates multiple Enumerables" do
      @array1 = [1,5,3]
      @array2 = [2,9,4]
      @zip = Enumerating.concatenating(@array1, @array2)
      @zip.to_a.should == [1,5,3,2,9,4]
    end

    it "is lazy" do
      @zip = Enumerating.concatenating([3,4], [1,2].with_time_bomb)
      @zip.take(3).should == [3,4,1]
    end
    
  end
  
end