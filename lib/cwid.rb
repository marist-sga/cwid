require 'faraday'
require 'faraday_middleware'
require 'multi_xml'

require_relative 'cwid/configuration'
require_relative 'cwid/person'

module CWID
  class << self
    attr_accessor :configuration

    # Configure the Gem's credentials.
    #
    # @param  [Proc]
    # @return [CWID::Configuration] The Configuration instance.
    def configure
      # Create a new configuration and yield it to a block
      self.configuration ||= Configuration.new

      yield(configuration)

      return configuration
    end

    # Perform a lookup using specific terms.
    #
    # @param  [Hash]   terms The search terms in a hash (`cwid: 20045405`, `name: "Douglas Adams"`).
    # @return [Person]       The person that belongs to that CWID.
    def lookup(terms = {})
      # Format the CWID if that's what we're getting.
      if terms[:cwid]
        terms = format(terms.values.first)
      else
        terms = terms.values.first
      end

      # Make the request to the LDAP server
      req = self.connection.get do |r|
        r.url self.configuration.search_path + terms
      end

      # Return nil if there's a nil directory return
      if req.body['directory'].nil?
        return nil
      end

      # Return nil if there aren't any results
      if req.body['directory'] && (req.body['directory'].empty? || req.body['directory'].nil?)
        return nil

      # Otherwise, create a new Person out of it
      else
        results = []

        if req.body['directory']['person'].is_a?(Hash)
          results << Person.new(req.body['directory']['person'])
        else
          req.body['directory']['person'].each do |r|
            results << Person.new(r)
          end
        end

        return results
      end
    end

    # Formats a CWID to remove special characters and extra numbers.
    #
    # @param  [Integer, String] cwid The CWID to be formatted
    # @return [String]               The formatted CWID
    def format(cwid)
      # Convert the input to a string
      cwid = cwid.to_s

      # Remove anything other than the numbers
      cwid = cwid.gsub(/[^0-9 ]/, '')

      # Remove spaces
      cwid = cwid.gsub(/\s+/, '')

      # If it's more than 8 characters, it has the card code as well
      if cwid.length > 8
        cwid = cwid[0..7]
      end

      cwid
    end

    # The Faraday connection being used by the Gem.
    #
    # @return [Faraday::Connection] The Faraday connection.
    def connection
      Faraday.new(url: self.configuration.base_url) do |f|
        f.response :xml, :content_type => /\bxml$/
        f.adapter :net_http
        f.basic_auth self.configuration.username, self.configuration.password
      end
    end

    # Check and see if the Gem can communicate with the LDAP server.
    #
    # @return [Boolean] True for connected, false for not.
    def connected?
      result = true

      begin
        req = self.connection.get do |r|
          r.url self.configuration.search_path
          r.options.timeout = 2
          r.options.open_timeout = 1
        end
      rescue Faraday::ConnectionFailed
        result = false
      end

      result
    end
  end
end
