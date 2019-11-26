class Door
  attr_reader :entity
  attr_accessor :revealed
  def initialize(entity)
    @entity = entity
    @revealed = false
  end
end
