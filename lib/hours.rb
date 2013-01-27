class Hours < Struct.new(:from, :to)
  def inspect
    "#{from} => #{to}"
  end
end
