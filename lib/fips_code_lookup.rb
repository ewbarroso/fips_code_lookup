# frozen_string_literal: true

require_relative "fips_code_lookup/version"

module FipsCodeLookup
  class Error < StandardError; end

  STATE_POSTAL_CODES = %w[AL AK AZ AR CA CO CT DE DC FL GA HI ID IL IN IA KS
                          KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC
                          ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY
                          AS GU MP PR UM VI].freeze

  def self.county(state_param, name)
    # Headers — AL,01,001,Autauga County,H1
    File.foreach(county_filename(state_param)) do |row|
      state_pc, state_fips, county_fips, county, class_code = row.split(",")
      if county == name
        return { "county_fips": county_fips, "state_fips": state_fips,
                 "fips_class": class_code.gsub(/\n/, "") }
      end
    end
  end

  def self.state_postal_code(state)
    state_file = File.join(File.dirname(__FILE__), "/state.csv")
    # HEADERS — 01,AL,Alabama, 01779775
    File.foreach(state_file) do |row|
      state_fips, state_pc, state_name, geo_id = row.split(",")
      if state == state_fips || state.upcase == state_pc || state.upcase == state_name.upcase || state == geo_id.gsub(/\n/, "")
        return state_pc
      end
    end
  end

  def self.county_filename(state)
    state_code = if STATE_POSTAL_CODES.include?(state.upcase)
                   state.upcase
                 else
                   state_postal_code(state)
                 end
    File.join(File.dirname(__FILE__), "/county/#{state_code}.csv")
  end
end
