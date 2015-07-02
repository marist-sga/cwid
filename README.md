
## Contributing

1. Fork it (https://github.com/marist-sga/cwid/fork)
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request# CWID

A simple Gem for requesting student and employee information from the LDAP server using Campus-Wide Identification (CWID) numbers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cwid', github: 'marist-sga/cwid'
```

And then execute:

```
$ bundle
```

## Usage

```ruby
# Configuration
CWID.configure do |c|
  c.username = 'Dennis'
  c.password = 'Murray'
end

# Lookups
person = CWID.lookup(cwid: '20045405') # => #<CWID::Person>

person.first_name # => 'Ethan'
person.last_name # => 'Turkeltaub'

# Formatting
CWID.format('?200-45-4051&;') # => '20045405'
```

## Frequently Asked Questions

### Why are my requests hanging?

**You must be connected to the Marist network in order to perform lookups**, whether that is with a VPN connection or directly on-campus.

### Why aren't I getting any results for a CWID?

There are a few reasons why the LDAP server won't return a record:

- Certain employment codes are filtered.
- `MaristInfoRestrict` is turned on.

## Contributing

1. Fork it (https://github.com/marist-sga/cwid/fork)
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request
