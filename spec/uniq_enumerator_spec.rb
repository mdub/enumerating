require "spec_helper"
require "uniq_enumerator"

describe UniqEnumerator do
  
  before do
    @array = [1,3,2,4,3,5,4,6]
    @uniq_enum = UniqEnumerator.new(@array.to_enum)
  end

  it "removes duplicates" do
    @uniq_enum.to_a.should == [1,3,2,4,5,6]
  end
  
end