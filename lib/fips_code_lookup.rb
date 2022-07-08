# frozen_string_literal: true

require_relative "fips_code_lookup/version"

module FipsCodeLookup
  class Error < StandardError; end

  # Your code goes here...
  def county(state, name)
    # lookup state code to file
    # parse file for name and return fips code
    csv = CSV.read("county/#{state}.csv", headers: true)
    code_row = csv.find { |row| row["NAME"] == name }
    puts "ROW: ", code_row
  end
end
