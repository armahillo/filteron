include Filteron
RSpec.describe Filteron do
  it "has a version number" do
    expect(Filteron::VERSION).not_to be nil
  end

  context "When the `filterable` concern is included in a model" do
    subject { User }
    it "initializes a @@filteron CVar" do
      expect(subject.class_variable_get(:@@filteron)).to be_is_a(Array)
    end

    describe "the `filter` method" do
      it "exists" do
        expect(subject).to respond_to(:filter)
      end
    end

    describe "the `filter_on` method" do
      let(:field) { "name" }
      context "with a basic filtering" do
        it "adds the field to the CVar" do
          expect(subject.class_variable_get(:@@filteron)).to be_include(field_to_scope_name(field))
        end
        it "creates a scope for that field" do
          expect(subject).to respond_to(field_to_scope_name(field))
        end
      end
      context "with a user provided scope" do
        before do
          User.create(name: "Alice", email: "alice@email.com")
          @bob = User.create(name: "Bob", email: "bob@email.com")
        end
        it "uses the given scope" do
          expect(subject.filter({:similar_email => "bob"})).to match_array([@bob])
        end
      end
    end
  end
end
