require "spec_helper"

describe "#lazily" do

  describe "#collect" do

    it "transforms items" do
      [1,2,3].lazily.collect { |x| x * 2 }.to_a.should == [2,4,6]
    end

    it "is lazy" do
      [1,2,3].with_time_bomb.lazily.collect { |x| x * 2 }.first.should == 2
    end

  end

  describe "#select" do

    it "excludes items that don't pass the predicate" do
      (1..6).lazily.select { |x| x%2 == 0 }.to_a.should == [2,4,6]
    end

    it "is lazy" do
      (1..6).with_time_bomb.lazily.select { |x| x%2 == 0 }.first == 2
    end

  end

  describe "#reject" do

    it "excludes items that do pass the predicate" do
      (1..6).lazily.reject { |x| x%2 == 0 }.to_a.should == [1,3,5]
    end

    it "is lazy" do
      (1..6).with_time_bomb.lazily.reject { |x| x%2 == 0 }.first == 1
    end

  end

end
