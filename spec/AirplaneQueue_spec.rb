require 'spec_helper'

describe AirplaneQueue do
  describe "initialize" do
    it "creates an empty airplane queue" do
      aq = AirplaneQueue.new
      expect(aq.waiting).to eq 0
    end
  end
end
