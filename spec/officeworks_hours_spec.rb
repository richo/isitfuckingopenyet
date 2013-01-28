require File.expand_path("../spec_helper", __FILE__)

describe Engines::Officeworks::OfficeworksStore do
  it "Should handle simple day lookups" do
    @raw_store = OFFICEWORKS_STORES[0]
    @store = Engines::Officeworks::OfficeworksStore.new(@raw_store)

    value = Hours.new(
            TimeWithoutDate.new(9, 0),
            TimeWithoutDate.new(18, 0)
          )

    @store.hours_for(1).should == value
  end
end
