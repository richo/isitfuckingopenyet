require File.expand_path("../spec_helper", __FILE__)

describe Hours do
  it "Should include times" do
    now = Time.mktime(2013, 1, 22, 13) # 1pm on a tuesday
    from = TimeWithoutDate.new(6, 00)
    to = TimeWithoutDate.new(22, 00)
    hours = Hours.new(from, to)

    hours.should include now

  end
end
