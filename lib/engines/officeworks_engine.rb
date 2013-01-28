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

    class OfficeworksStore
      def initialize(data)
        @data = data
      end
      attr_reader :data

      def raw_hours
        unless @raw_hours
          @raw_hours = []
          (1..5).each do |h|
            @raw_hours << data["hours#{h}"] unless data["hours#{h}"].empty?
          end
        end
        @raw_hours
      end

      def hours
        (0...7).map do |day|
          hours_for(day)
        end
      end

      def hours_for(day)
        raw_hours.each do |day_hours|
          if day_hours.start_with? DAY_MAP[day]
            return parse_hours(day_hours)
          end
        end

        # TODO Deal with Tue - Fri as a range.
        raise "Day ranges not yet implemented"
      end

      def parse_hours(hours_string)
        if hours_string =~ /^[^:]+: (\d)+(am|pm) - (\d)+(am|pm)$/
          from = $1.to_i
          if $2 == "pm"
            from += 12
          end

          to = $3.to_i
          if $4 == "pm"
            to += 12
          end

          Hours.new(
            TimeWithoutDate.new(from, 0),
            TimeWithoutDate.new(to, 0)
          )
        end
      end

      DAY_MAP = {
        0 => "Sun",
        1 => "Mon",
        2 => "Tue",
        3 => "Wed",
        4 => "Thu",
        5 => "Fri",
        6 => "Sat"
      }
    end



  end
  ENGINES["officeworks"] = Officeworks
end
