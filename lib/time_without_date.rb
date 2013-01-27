class TimeWithoutDate < Struct.new(:hours, :mins)

  def self.from_timestring(str)
    new(*str.split(":").map(&:to_i))
  end

  def to_s
    "#{hours}:#{mins}"
  end
end
