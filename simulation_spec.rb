require_relative 'simulation'

describe "The simulation runs" do
  context "There are 1000 runs and 100 doors" do
    before :all do
      @simulation = Simulation.new(100, 1000)
    end
    it "should output the results" do
      @simulation.run
    end
  end
end
