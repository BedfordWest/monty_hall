require_relative 'game'
require_relative 'door'

describe "game" do
  
  #pass the number of doors desired - let's use 3 for tests
  total = 3
  before :each do
    @game = Game.new(total)
    @game.choose(0)
  end
  
  it "should only have one car" do
    expect(@game.car_count).to eq(1)
  end
  
  it "should have total - 1 goats" do
    expect(@game.goat_count).to eq(total - 1)
  end
  
  it "should not reveal choie" do
    @game.reveal_goat
    expect(@game.revealed).not_to eq(@game.choice)
  end
  
  it "should reveal goat" do
    @game.reveal_goat
    revealed_entity = @game.doors[@game.revealed].entity
    expect(revealed_entity).to eq("goat")
  end
  
  context "stay scenario with reveal" do
    before :each do
      @game.reveal_goat
      @game.decide("stay")
    end
    it "has the end choice of original choice" do
      expect(@game.end_choice).to eq(0)
    end
  end
  
  context "switch scenario" do
    before :each do
      @game.reveal_goat
      @game.decide("switch")
    end
    it "has the end choice not the same as original choice" do
      expect(@game.end_choice).not_to eq(0)
    end
    it "has the end choice not the same as revealed goat" do
      expect(@game.end_choice).not_to eq(@game.revealed)
    end
  end
  
end

describe "picked car game" do
  before :each do
    @game = Game.new(["goat", "car", "goat"])
    @game.choose(1)
  end
  context "stayed with car" do
    before :each do
      @game.reveal_goat
      @game.decide("stay")
    end
    it "should end with a car" do
      door = @game.end_door
      expect(door.entity).to eq("car")
    end
  end
  
  context "switched to goat" do
    before :each do
      @game.reveal_goat
      @game.decide("switch")
    end
    it "should end with a goat" do
      door = @game.end_door
      expect(door.entity).to eq("goat")
    end
  end
end

describe "picked goat game" do
  before :each do
    @game = Game.new(["goat", "car", "goat"])
    @game.choose(0)
  end
  context "stayed with goat" do
    it "should end with a goat" do
      @game.reveal_goat
      @game.decide("stay")
      door = @game.end_door
      expect(door.entity).to eq("goat")
    end
  end
  
  context "switched to car" do
    it "should end with a car" do
      @game.reveal_goat
      @game.decide("switch")
      door = @game.end_door
      expect(door.entity).to eq("car")
    end
  end
end
