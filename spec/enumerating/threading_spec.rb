require "spec_helper"

describe Enumerable do

  describe "#threading" do

    it "acts like #collect" do
      [1,2,3].threading(5) { |x| x * 2 }.to_a.should == [2,4,6]
    end

    it "runs things in separate threads" do
      [1,2,3].threading(5) { Thread.current.object_id }.to_a.uniq.size.should eq(3)
    end

    it "is lazy" do
      [1,2,3].with_time_bomb.threading(2) { |x| x * 2 }.first.should == 2
    end

    def round(n)
      (n * 100).round.to_f / 100.0
    end

    it "runs the specified number of threads in parallel" do
      delays = [0.01, 0.01, 0.01]
      start = Time.now
      delays.threading(2) do |delay|
        sleep(delay)
      end.to_a
      round(Time.now - start).should eq(0.01 * 2)
    end

    it "acts as a sliding window" do
      delays = [0.05, 0.04, 0.03, 0.02, 0.01]
      start = Time.now
      elapsed_times = delays.threading(3) do |delay|
        sleep(delay)
        round(Time.now - start)
      end
      elapsed_times.to_a.should eq([0.05, 0.04, 0.03, 0.07, 0.06])
    end

    it "surfaces exceptions" do
      lambda do
        [1,2,3].threading(5) { raise "hell" }.to_a
      end.should raise_error(RuntimeError, "hell")
    end

  end

end
