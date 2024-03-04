# frozen_string_literal: true

require_relative "fips_lookup/version"
require 'csv' 

module FipsLookup

  STATE_POSTAL_CODES = %w[AL AK AZ AR CA CO CT DE DC FL GA HI ID IL IN IA KS
                          KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC
                          ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY
                          AS GU MP PR UM VI].freeze

  # when county not found and raise StandardError, input is not memoized - stack bubbles with error
  # when county not found without raise error, input is memoized and nil is returned
  def self.county(state_param, county_name_param)
    lookup = [state_param, county_name_param]
    @_county_fips ||= {}
    # puts "fips memo hash: ", @_county_fips
    @_county_fips[lookup] ||= county_lookup(state_param, county_name_param)
  end

  def self.county_lookup(state_param, county_name_param)
    state_code = find_state_code(state_param)

    CSV.foreach(state_county_file(state_code)) do |county_row|
      # state (AL), state code (01), county fips (001), county name (Augtauga County), county class code (H1)
      if county_row[3].upcase == county_name_param.upcase
        return county_row[2]
      end
    end
    # retry with variations of county param?

    # raise StandardError, "No county found matching: #{county_name_param}"
  end

  # state code lookups (geo id / ANSI - memoize whole state file ?)

  def self.find_state_code(state_param)
    return state_param.upcase if STATE_POSTAL_CODES.include?(state_param.upcase)

    CSV.foreach(state_file) do |state_row|
      # state code (01), state postal code (AL), state name (Alabama), state ansi code (01779775)
      if state_param == state_row[0] || state_param.upcase == state_row[2].upcase || state_param == state_row[3]
        return state_row[1].upcase if STATE_POSTAL_CODES.include?(state_row[1].upcase)
      end
    end
    raise StandardError, "No state found matching: #{state_param}"
  end

  private

  def self.state_county_file(state_code)
    File.join(File.dirname(__FILE__), "/county/#{state_code}.csv")
  end

  def self.state_file
    File.join(File.dirname(__FILE__), "/state.csv")
  end
end
