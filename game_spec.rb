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
  
  it "should not reveal choice" do
    @game.reveal_goat
    @game.doors.each_with_index do |door, i|
      if door.revealed
        expect(i).not_to eq(@game.choice)              
      end
    end
  end
  
  it "should reveal only goats" do
    @game.reveal_goat
    @game.doors.each_with_index do |door, i|
      if door.revealed
        expect(door.entity).to eq("goat")
      end
    end    
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
      expect(@game.end_door.revealed).to eq(false)
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

describe "game with 100 doors" do
  before :each do
    @game = Game.new(100)
    @game.choose(10)
  end

  context "goats have been revealed" do
    before :each do
      @game.reveal_goat
    end

    it "should have 98 revealed doors" do
      revealed = 0
      @game.doors.each do |door|
        revealed += 1 if door.revealed
      end
      expect(revealed).to eq(98)
    end

    it "should have all revealed doors be goats" do
      @game.doors.each do |door|
        if door.revealed
          expect(door.entity).to eq("goat")
        end
      end
    end
  end
end
