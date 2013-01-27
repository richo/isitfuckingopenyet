class SearchController < BaseController

  def search
    return engine.stores(location)
  end

  def location
    raise "No location given" unless params[:postcode] # TODO
    UserLocation.from_postcode(params[:postcode])
  end

  def engine
    store = params[:store]
    unless Engines::ENGINES.include? store
      raise "Invalid store"
    end

    @engine ||= Engines::ENGINES[store].new
  end

end
