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
