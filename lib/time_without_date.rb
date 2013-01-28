class TimeWithoutDate < Struct.new(:hours, :mins)

  def self.from_timestring(str)
    new(*str.split(":").map(&:to_i))
  end

  def to_s
    "#{hours}:#{mins}"
  end

  # Return an absolute value for this TimeWithoutDate suitable for sorting
  def abs
    hours + mins * 60
  end
end
