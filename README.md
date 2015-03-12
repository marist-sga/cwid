# CWID

A simple Gem for Marist Campus-Wide Identification lookup.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cwid', github: 'marist-sga/cwid'
```

And then execute:

    $ bundle


## Usage

```ruby
CWID.configure do |c|
  c.username = 'Dennis'
  c.password = 'Murray'
end

CWID.lookup(20045405) # => #<CWID::Person>
```
### Why aren't I getting any results for a CWID?

There are a few reasons why the LDAP server won't return a record:

- Certain employment codes are filtered.
- `MaristInfoRestrict` is turned on.
