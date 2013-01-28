module Engines
  class Officeworks < Base
    FETCH_URL = "http://www.officeworks.com.au/retail/content/Stores"

    class << self

      def display_name
        "Officeworks"
      end

    end

    def stores(loc)
      OFFICEWORKS_STORES.within(0.05, loc).map do |s|
        Store.new(
          :hours => Hours.new(0, 0),
          :location => Location.new(:lat => s['lat'],
                       :lon => s['lon'])
        )
      end

    end

  end
  ENGINES["officeworks"] = Officeworks
end
