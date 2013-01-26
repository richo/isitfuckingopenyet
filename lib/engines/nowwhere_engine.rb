module Engines
  class NowWhere < Base
    def backend_url
      "http://apps.nowwhere.com.au/#{nowwhere_app_name}/locator/FindNearest.ashx"
    end

    def query_params
      {
        "x" => lat,
        "y" => lon,
        "storeType" => ""
      }
    end

    def query_headers
      {
        "Referer" => "http://apps.nowwhere.com.au/woolworths/locator/default.aspx"
      }
    end

    def stores
      fetch_data.map do |record|
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

    def fetch_data
      uri = URI(backend_url)
      uri.query = URI.encode_www_form(query_params)

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
        data = JSON.load(respbody)
      end
    end

  end
end
