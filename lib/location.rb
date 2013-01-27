class Location

  def self.from_postcode(postcode)
    new(:postcode => postcode)
  end

  def initialize(opts)
    @opts = opts
  end
  attr_accessor :opts

  def postcode
    @postcode ||= opts[:postcode].to_i || get_postcode
  end

  def lat
    @lat ||= opts[:lat] || get_lat
  end

  def lon
    @lon ||= opts[:lon] || get_lon
  end

  def get_postcode
    raise "Not implemented"
  end

  def get_lat
    POSTCODES[postcode][4]
  end

  def get_lon
    POSTCODES[postcode][5]
  end

end
