module Engines
  class Woolworths < Base
    def nowwhere_app_name
      "woolworths".freeze
    end

    def lat
      location.latlong[:lat]
    end

    def lon
      location.latlong[:lon]
    end
  end
  ENGINES["woolworths"] = Woolworths
end
