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

  end
  
  describe "dequeue" do
    it "returns nil when all queues are empty" do
      expect(@aq.dequeue).to eq nil
    end
  end

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
    [{type: "cargo", size: "small", name: "smallcargo"}, {type: "cargo", size: "large", name: "largecargo"}, {type: "passenger", size: "small", name: "smallpassenger"}, {type: "passenger", size: "large", name: "largepassenger"}].each do |p|
      it "returns #{p[:name]} when given type #{p[:type]} and size #{p[:size]}" do
        expect(@aq._buildType(p)).to eq p[:name]
      end
    end
  end
end
