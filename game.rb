require_relative 'door.rb'

class Game
  attr_reader :end_choice
  attr_reader :end_door
  attr_reader :revealed
  attr_reader :doors
  attr_reader :choice
  
  def initialize(doors)
    if doors.is_a? Integer
      build_doors_int(doors)
    elsif doors.is_a? Array
      build_doors_array(doors)
    else
      raise ArgumentError("Please provide a number or array for doors!")
    end
  end
  
  def choose(number)
    @choice = number
  end
  
  def reveal_goat
    @revealed = rand(@doors.length)
    if ((@revealed.eql? @choice) || (@doors[@revealed].entity.eql? "car"))
      reveal_goat
    end
  end
  
  #stay or switch
  def decide(decision)
    if decision.eql?("stay")
      @end_choice = @choice
      @end_door = @doors[@end_choice]
      return
    elsif decision.eql?("switch")
      original_choice = @choice
      while (@choice.eql?(original_choice) || @choice.eql?(@revealed)) do
        @choice = rand(@doors.length)
      end
      @end_choice = @choice
      @end_door = @doors[@end_choice]
    else
      raise ArgumentError("Stay or switch please")
    end
  end
  
  def build_doors_int(number)
    @doors = Array.new
    car = rand(number)
    number.times { |num| 
      if num.eql? car
        @doors[num] = Door.new("car")
      else
        @doors[num] = Door.new("goat")
      end
    }
  end
  
  def build_doors_array(array)
    @doors = Array.new
    array.each { |door|
      @doors.push Door.new(door)
    }
  end
  
  def car_count
    count = 0
    @doors.each { |door|
      if door.entity.eql? "car"
        count += 1
      end
    }
    count
  end
  
  def goat_count
    count = 0
    @doors.each { |door|
      if door.entity.eql? "goat"
        count += 1
      end
    }
    count
  end
  
end
