module Engines
  def self.[](key)
    if (engine = self.const_get(key))
      return engine
    else
      raise "No Such Engine"
    end
  end

  class Base

    def fetch
      uri = URI(FETCH_URL)
      req = Net::HTTP.get(uri)
      return get_hours(req)
    end

  end
end
