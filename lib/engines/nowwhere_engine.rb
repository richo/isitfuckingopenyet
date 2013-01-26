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
        data = JSON.parse(resp.body)
      end
    end

  end
end
