RSpec.describe Filteron do
  it "has a version number" do
    expect(Filteron::VERSION).not_to be nil
  end

  context "When the concern is included" do
    before do
      class TestApplicationRecord
        include Filterable
      end
    end
    it "initializes a @@filteron CVAR" do
      expect(TestApplicationRecord.class_variable_get(:@@filteron)).to match_array([])
    end
    it "has a `filter` method" do
      expect(TestApplicationRecord).to respond_to(:filter)
    end
  end
end
