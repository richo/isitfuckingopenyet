module Engines
  class NowWhere < Base
    def backend_url
      "http://apps.nowwhere.com.au/#{nowwhere_app_name}/locator/FindNearest.ashx"
    end

    def query_headers
      {
        "Referer" => "http://apps.nowwhere.com.au/woolworths/locator/default.aspx"
      }
    end

    def stores(loc)
      fetch_data(loc).map do |record|
        Store.new(:hours => get_hours(record), :location => record["Street"])
      end
    end

    def get_hours(record)
      {
        :monday => record["MonHours"],
        :tuesday => record["TuesHours"],
        :wednesday => record["WedHours"],
        :thursday => record["ThursHours"],
        :friday => record["FriHours"],
        :saturday => record["SatHours"],
        :sunday => record["SunHours"]
      }
    end

    def fetch_data(loc)
      uri = URI(backend_url)
      uri.query = URI.encode_www_form({
        "x" => loc.lon,
        "y" => loc.lat,
        "storeType" => ""
      })

      req = Net::HTTP::Get.new(uri.request_uri)
      query_headers.each do |k, v|
        req[k] = v
      end

      resp= Net::HTTP.start(uri.host, uri.port) do |http|
        http.request req
      end

      if resp.is_a?(Net::HTTPSuccess)
        respbody = resp.body
        respbody.sub!(/\A[^\[]*/, "")
        respbody.sub!(/[^\]]*\z/, "")
        return JSON.load(respbody)
      else
        raise "Backend returned #{resp.inspect}"
      end
    end

  end
end
