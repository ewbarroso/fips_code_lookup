# frozen_string_literal: true

require_relative "fips_code_lookup/version"
require 'csv' 

module FipsCodeLookup
  class Error < StandardError; end

  STATE_POSTAL_CODES = %w[AL AK AZ AR CA CO CT DE DC FL GA HI ID IL IN IA KS
                          KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC
                          ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY
                          AS GU MP PR UM VI].freeze

  # look up how ruby gem's should throw errors within their functions (404/ county not found / etc.)
  # ^ when error does it fail gracefully or keep searching & memoizing ?

  def self.county_fips(state_param, county_name_param)
    # check if file from state exists? 
    # check if county is within file ?(OR returns nil!!)
    # ^ check how error handling is stored within instance variable (memoization)

    lookup = [state_param, county_name_param]
    @_county_fips ||= {}
    @_county_fips[lookup] ||= county_fips_lookup(state_param, county_name_param)
  end

  def self.county_fips_lookup(state_param, county_name_param)
    # return if no file ? (or check if this will exit from errors before)

    CSV.foreach(county_filename(state_param)) do |county_row|
      #CSV columns: state code, state fips, county fips, county name, county class code
      if county_row[3].upcase == county_name_param.upcase
        return county_row[2]
      end
    end
    # what to return if county not found?
  end

  # private ?

  def self.find_state_code(state_param)
    return state_param.upcase if STATE_POSTAL_CODES.include?(state_param.upcase)

    state_file_name = File.join(File.dirname(__FILE__), "/state.csv")
    CSV.foreach(state_file_name) do |state_row|
      # CSV columns: 01,AL,Alabama, 01779775
      if state_param == state_row[0] || state_param.upcase == state_row[2].upcase || state_param == state_row[3]
        return state_row[1].upcase
      end

      # what to return /error & exit if state code is not found?
    end
  end

  def self.county_filename(state_param)
    state_code = find_state_code(state_param)

    # error & quit if no state_code ?
    File.join(File.dirname(__FILE__), "/county/#{state_code}.csv")
  end
end
