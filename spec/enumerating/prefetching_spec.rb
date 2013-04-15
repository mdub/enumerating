require "spec_helper"

describe Enumerable do

  Counter = Class.new do

    include Enumerable

    def initialize(source)
      @source = source
      @number_yielded = 0
    end

    def each
      @source.each do |item|
        @number_yielded += 1
        yield item
      end
    end

    attr_reader :number_yielded

  end

  describe "#prefetching" do

    let(:source) { [1, 2, 3, 4, nil, false, 7] }

    it "yields all items" do
      source.prefetching(2).to_a.should eq(source)
      source.prefetching(3).to_a.should eq(source)
    end

    it "is stateless" do
      source.prefetching(2).first.should eq(source.first)
      source.prefetching(2).first.should eq(source.first)
    end

    it "is lazy" do
      source.with_time_bomb.prefetching(2).first.should eq(source.first)
    end

    it "pre-computes the specified number of elements" do
      counter = Counter.new(source)
      counter.prefetching(2).take(1)
      counter.number_yielded.should eq(3)
    end

    context "with a buffer size of zero" do

      it "does not pre-fetch anything" do
        counter = Counter.new(source)
        counter.prefetching(0).take(1)
        counter.number_yielded.should eq(1)
      end

    end

    context "with a buffer bigger than the source Enumerable" do

      it "yields all items" do
        source.prefetching(20).to_a.should eq(source)
      end

    end

  end

end
