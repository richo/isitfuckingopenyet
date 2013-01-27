module Engines
  class Officeworks < Base
    FETCH_URL = "http://www.officeworks.com.au/retail/content/Stores"

    def name
      "officeworks"
    end

    def stores

    end

  end
  ENGINES["officeworks"] = Officeworks
end
