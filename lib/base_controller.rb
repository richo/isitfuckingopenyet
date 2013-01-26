class BaseController

  def initialize(params)
    @params = params
  end
  attr_accessor :params


  def location
    UserLocation.new
  end

end
