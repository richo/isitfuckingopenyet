class Store < Struct.new(:hours, :location)
  def initialize(opts)
    super(opts[:hours], opts[:location])
  end

end
