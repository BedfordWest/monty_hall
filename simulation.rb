require_relative 'game.rb'

class Simulation
  
  def initialize(num_doors, num_runs)
    @num_doors = num_doors
    @num_runs = num_runs
  end
  
  def run
    run_for("stay")
    run_for("switch")
  end
  
  def run_for(stay_or_switch)
    result = run_times(stay_or_switch)
    puts "The result for #{stay_or_switch} was\
 #{result[0]} cars and #{result[1]} goats!"
  end
  
  def run_times(stay_or_switch)
    cars = 0
    goats = 0
    @num_runs.times do
      result = run_once(stay_or_switch)
      if result.eql? "goat"
        goats += 1
      else
        cars += 1
      end
    end
    [cars, goats]
  end
  
  def run_once(stay_or_switch)
    game = Game.new(@num_doors)
    game.choose(rand(@num_doors))
    game.reveal_goat
    game.decide(stay_or_switch)
    game.end_door.entity
  end
  
end
