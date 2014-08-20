require 'spec_helper'

describe AirplaneQueue do
  
  before :each do
    @aq = AirplaneQueue.new
  end

  describe "initialize" do
    it "creates an empty airplane queue" do
      expect(@aq.waiting).to eq 0
    end
  end
  
  describe "enqueue" do
    it "returns nil when params do not build a valid AC type" do
      expect(@aq.enqueue("cat", size: "tiny", type: "carnivore")).to eq nil
    end
    it "increases waiting count after success" do
      @aq.enqueue("plane", size: "small", type: "cargo")
      expect(@aq.waiting).to eq 1
    end
  end
  
  describe "dequeue" do
    it "returns nil when all queues are empty" do
      expect(@aq.dequeue).to eq nil
    end
    it "returns a plane that has been queued" do
      @aq.enqueue("helocopter", size: "small", type: "cargo")
      expect(@aq.dequeue).to eq "helocopter"
    end
    it "decreases waiting count after dequeue" do
      @aq.enqueue("plane", size: "small", type: "cargo")
      @aq.dequeue
      expect(@aq.waiting).to eq 0
    end
  end
  
  #test patterns of operations to cover some of the more complex behavior expected
  describe "priority behavior" do
    it "allows for the storage of an arbitrary number of planes" do
      (1..100).each {|n| @aq.enqueue("plane#{n}", size: "small", type: "cargo")}
      (1..99).each {|n| @aq.dequeue}
      expect(@aq.dequeue).to eq "plane100"
    end
    it "dequeues passenger planes first when passenger and cargo are waiting" do
      @aq.enqueue("UPS", size: "large", type: "cargo")
      @aq.enqueue("Delta", size: "small", type: "passenger")
      expect(@aq.dequeue).to eq "Delta"
      expect(@aq.dequeue).to eq "UPS"
    end
    it "dequeues large planes before small planes when they are the same type" do
      @aq.enqueue("DHL", size: "small", type: "cargo")
      @aq.enqueue("FedEx", size: "large", type: "cargo")
      expect(@aq.dequeue).to eq "FedEx"
      expect(@aq.dequeue).to eq "DHL"
    end
    it "returns planes of the same type in FIFO order" do
      @aq.enqueue("DC9", size: "small", type: "passenger")
      @aq.enqueue("DC10", size: "small", type: "passenger")
      expect(@aq.dequeue).to eq "DC9"
      expect(@aq.dequeue).to eq "DC10"
    end
  end

  #test the helper method that converts params into AC type string
  describe "_buildType" do
    it "returns nil when not given a hash" do
      expect(@aq._buildType(1)).to eq nil
    end
    it "returns nil when not given :size key" do
      expect(@aq._buildType(type: "cargo")).to eq nil
    end
    it "returns nil when not given :type key" do
      expect(@aq._buildType(size: "small")).to eq nil
    end
    it "returns nil when assembed type name isn't an ACTYPE" do
      expect(@aq._buildType(type: "cargenger", size: "small")).to eq nil
    end
    #step through a list of all 4 acceptable size/type combinations and make sure they work
    [{type: "cargo", size: "small", name: "smallcargo"}, {type: "cargo", size: "large", name: "largecargo"}, {type: "passenger", size: "small", name: "smallpassenger"}, {type: "passenger", size: "large", name: "largepassenger"}].each do |p|
      it "returns #{p[:name]} when given type #{p[:type]} and size #{p[:size]}" do
        expect(@aq._buildType(p)).to eq p[:name]
      end
    end
  end
end
