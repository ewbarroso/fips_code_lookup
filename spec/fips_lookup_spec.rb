# frozen_string_literal: true

RSpec.describe FipsLookup do
  it "has a version number" do
    expect(FipsLookup::VERSION).not_to be nil
  end

  describe ".county_lookup" do
    context "with searchable state and county params" do
      it "returns the proper fips code" do
        expect(FipsLookup.county_lookup("Al", "Autauga County")).to eq("01001")
      end
    end

    context "with an invalid county param" do
      context "and return_nil paramater is not used" do
        it "returns an error" do
          expect{FipsLookup.county_lookup("AL", "Autauga")}.to raise_error(StandardError, "No county found matching: Autauga")
        end
      end
      context "and return_nil paramater is used" do
        it "returns nil" do
          expect(FipsLookup.county_lookup("Alabama", "Autauga", true)).to eq(nil)
        end
      end
    end

    context "with an invalid state param" do
      context "and return_nil paramater is not used" do
        it "returns an error" do
          expect{FipsLookup.county_lookup("ZZ", "County")}.to raise_error(StandardError, "No state found matching: ZZ")
        end
      end
      context "and return_nil paramater is used" do
        it "returns nil" do
          expect(FipsLookup.county_lookup("ZZ", "County", true)).to eq(nil)
        end
      end
    end
  end

  describe ".county" do
    it "populates a memoized hash attribute accessor with state paramater and county paramater as lookups" do
      expect(FipsLookup.county("AL", "Autauga County")).to eq("01001")

      lookup = ["AL", "Autauga County"]
      expect(FipsLookup.county_fips[lookup]).to eq("01001")
    end
  end
end
