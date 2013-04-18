require "spec_helper"

module Enumerable

  unless method_defined?(:first)
    def first
      each do |first_item|
        return first_item
      end
    end
  end

end

describe Enumerable do

  describe "#collecting" do

    it "transforms items" do
      [1,2,3].collecting { |x| x * 2 }.to_a.should == [2,4,6]
    end

    it "is lazy" do
      [1,2,3].with_time_bomb.collecting { |x| x * 2 }.first.should == 2
    end

  end

  describe "#selecting" do

    it "excludes items that don't pass the predicate" do
      (1..6).selecting { |x| x%2 == 0 }.to_a.should == [2,4,6]
    end

    it "is lazy" do
      (1..6).with_time_bomb.selecting { |x| x%2 == 0 }.first == 2
    end

  end

  describe "#rejecting" do

    it "excludes items that do pass the predicate" do
      (1..6).rejecting { |x| x%2 == 0 }.to_a.should == [1,3,5]
    end

    it "is lazy" do
      (1..6).with_time_bomb.rejecting { |x| x%2 == 0 }.first == 1
    end

  end

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

  describe "#taking" do

    it "includes the specified number" do
      @array = [1,2,3,4]
      @array.taking(3).to_a.should == [1,2,3]
    end

    it "is lazy" do
      [1,2].with_time_bomb.taking(2).to_a.should == [1,2]
    end

    it "is stackable" do
      [1,2].taking(2).taking(2).to_a.should == [1,2]
    end

    it "copes with 0" do
      [].with_time_bomb.taking(0).to_a.should == []
    end

  end

  describe "#taking_while" do

    it "takes elements as long as the predicate is true" do
      @array = [2,4,6,3]
      @array.taking_while(&:even?).to_a.should == [2,4,6]
    end

    it "is lazy" do
      [2,3].with_time_bomb.taking_while(&:even?).to_a.should == [2]
    end

  end

  describe "#dropping" do

    it "excludes the specified number" do
      @array = [1,2,3,4]
      @array.dropping(2).to_a.should == [3,4]
    end

    it "is lazy" do
      [1,2,3,4].with_time_bomb.dropping(2).taking(1).to_a.should == [3]
    end

  end

  describe "#dropping_while" do

    it "drops elements as long as the predicate is true" do
      @array = [2,4,6,3,4]
      @array.dropping_while(&:even?).to_a.should == [3,4]
    end

    it "is lazy" do
      [2,3].with_time_bomb.dropping_while(&:even?).taking(1).to_a.should == [3]
    end

  end

  describe "#[]" do

    before do
      @evens = [1,2,3,4,5].collecting { |x| x * 2 }
    end

    it "finds the specified element" do
      @evens[2].should == 6
    end

    it "is lazy" do
      @evens.with_time_bomb[4].should == 10
    end

  end

end
