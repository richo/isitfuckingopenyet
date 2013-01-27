module Engines
  class Officeworks < Base
    FETCH_URL = "http://www.officeworks.com.au/retail/content/Stores"

    class << self

      def display_name
        "Officeworks"
      end

    end

    def stores(loc)
      OFFICEWORKS_STORES.within(0.05, loc)
    end

  end
  ENGINES["officeworks"] = Officeworks
end
