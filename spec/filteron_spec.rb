include Filteron
RSpec.describe Filteron do
  it "has a version number" do
    expect(Filteron::VERSION).not_to be nil
  end

  context "When the `filterable` concern is included" do
    before do
      class TestApplicationRecord < ApplicationRecordMock
        include Filterable
      end
    end
    it "initializes a @@filteron CVar" do
      expect(TestApplicationRecord.class_variable_get(:@@filteron)).to match_array([])
    end

    describe "the `filter` method" do
      it "exists" do
        expect(TestApplicationRecord).to respond_to(:filter)
      end
    end

    describe "the `filter_on` method" do
      before do
        @field = "name"
      end
      context "with a basic filtering" do
        before do
          class TestApplicationRecord
            filter_on "name" # FIXME: Using @field doesn't work here; why?
          end
        end

        it "adds the field to the CVar" do
          expect(TestApplicationRecord.class_variable_get(:@@filteron)).to match_array([field_to_scope_name(@field)])
        end
        it "creates a scope for that field" do
          expect(TestApplicationRecord).to respond_to(field_to_scope_name(@field))
        end
      end
      context "with a user provided scope" do
        before do
          class TestApplicationRecord < ApplicationRecordMock
            scope :similar_name, ->(name) { where("name LIKE ?", "%#{name}%") }
            filter_on "name", :similar_name
          end
        end
        it "uses the given scope" do
          allow(ApplicationRecordMock).to receive(:where).and_return(TestApplicationRecord)
          allow(TestApplicationRecord).to receive(:similar_name).and_return([0,1,2])

          expect(TestApplicationRecord.filter({:similar_name => "fred"})).to match_array([0,1,2])
        end
      end
    end
  end
end
