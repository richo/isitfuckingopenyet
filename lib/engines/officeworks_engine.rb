module Engines
  class Officeworks < Base
    FETCH_URL = "http://www.officeworks.com.au/retail/content/Stores"

    class << self

      def display_name
        "officeworks"
      end

    end

    def stores
    end

  end
  ENGINES["officeworks"] = Officeworks
end
