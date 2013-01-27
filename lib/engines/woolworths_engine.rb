module Engines
  class Woolworths < NowWhere

    class << self
      def display_name
        "Woolworths"
      end
    end

    def nowwhere_app_name
      "woolworths".freeze
    end

  end
  ENGINES["woolworths"] = Woolworths
end
