# frozen_string_literal: true

require_relative "fips_lookup/version"
require 'csv' 

module FipsLookup
  STATE_POSTAL_CODES = %w[AL AK AZ AR CA CO CT DE DC FL GA HI ID IL IN IA KS
                          KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC
                          ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY
                          AS GU MP PR UM VI].freeze

  class << self
    attr_accessor :county_fips

    def county(state_param, county_name_param, return_nil = false)
      lookup = [state_param, county_name_param]
      @county_fips ||= {}
      @county_fips[lookup] ||= county_lookup(state_param, county_name_param, return_nil)
    end

    def county_lookup(state_param, county_name_param, return_nil = false)
      state_code = find_state_code(state_param, return_nil)
      return nil if state_code.nil?

      CSV.foreach(state_county_file(state_code)) do |county_row|
        # state (AL), state code (01), county fips (001), county name (Augtauga County), county class code (H1)
        if county_row[3].upcase == county_name_param.upcase
          return county_row[2]
        end
      end

      raise StandardError, "No county found matching: #{county_name_param}" unless return_nil
    end

    def find_state_code(state_param, return_nil = false)
      return state_param.upcase if STATE_POSTAL_CODES.include?(state_param.upcase)

      CSV.foreach(state_file) do |state_row|
        # state code (01), state postal code (AL), state name (Alabama), state ansi code (01779775)
        if state_param == state_row[0] || state_param.upcase == state_row[2].upcase || state_param == state_row[3]
          return state_row[1].upcase if STATE_POSTAL_CODES.include?(state_row[1].upcase)
        end
      end

      raise StandardError, "No state found matching: #{state_param}" unless return_nil
    end

    private

    def state_county_file(state_code)
      File.join(File.dirname(__FILE__), "/county/#{state_code}.csv")
    end

    def state_file
      File.join(File.dirname(__FILE__), "/state.csv")
    end
  end
end
