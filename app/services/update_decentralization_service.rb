class UpdateDecentralizationService
  def initialize(id, active)
    @id = id
    @active = active
  end

  def perform
    Decentralization.find_by(id: @id).update active: @active
  end

end
