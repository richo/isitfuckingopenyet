class Hours < Struct.new(:from, :to)
  def inspect
    "#{from} => #{to}"
  end

  def include?(other)
    from.abs < other.abs && other.abs < to.abs
  end

end

# TODO
class Time

  def abs
    hour + 60 * min
  end

end
