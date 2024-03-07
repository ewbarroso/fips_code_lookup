# FipsLookup

Welcome! This gem functions as a lookup that can be used to identify county and state FIPS codes. 

What are FIPS codes? Answer from the United States Federal Communcations Commission (FCC): [source](https://transition.fcc.gov/oet/info/maps/census/fips/fips.txt)

> Federal Information Processing System (FIPS) Codes for States and Counties
>
> FIPS codes are numbers which uniquely identify geographic areas.  The number of 
digits in FIPS codes vary depending on the level of geography.  State-level FIPS
codes have two digits, county-level FIPS codes have five digits of which the 
first two are the FIPS code of the state to which the county belongs.

FIPS codes are updated by the US census department and [accessed here](https://www.census.gov/library/reference/code-lists/ansi.html)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fips_lookup'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install fips_lookup

## Usage

General usage & expected return: 

Memoization: 

Error Handleing:

## Development

Download the repository locally, and from the directroy run `bin/setup` to install gem dependencies.

Check installation and any changes by running `rspec` to run the tests. 

Use `bin/console` to open IRB console with FipsLookup gem included and ready to use.

To install this gem onto your local machine, run `bundle exec rake install`. 

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### New to Ruby?
On Mac, follow steps 1 and 2 of [this guide](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-macos) to install ruby with rbenv using brew.

For PC, consult offical ruby language [installation guides](https://www.ruby-lang.org/en/documentation/installation/).

## Contributing

Bug reports and pull requests are welcome on GitHub at the [FipsLookup repo](https://github.com/3barroso/fips_lookup). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/3barroso/fips_lookup/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FipsLookup project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/3barroso/fips_lookup/blob/main/CODE_OF_CONDUCT.md).
