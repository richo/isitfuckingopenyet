module Engines
  ENGINES = {}
  def self.[](key)
    if (engine = ENGINES[key])
      return engine
    else
      raise "No Such Engine"
    end
  end

  class Base

    def self.display_name
      name
    end

    def fetch
      uri = URI(FETCH_URL)
      req = Net::HTTP.get(uri)
      return get_hours(req)
    end

  end
end
