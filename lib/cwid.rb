require 'faraday'
require 'faraday_middleware'
require 'multi_xml'

require_relative 'cwid/configuration'
require_relative 'cwid/person'

module CWID
  class << self
    attr_accessor :configuration

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)

      return configuration
    end

    def lookup(cwid)
      req = self.connection.get do |r|
        r.url self.configuration.search_path + format(cwid)
      end

      if req.body['directory'].empty?
        nil
      else
        Person.new(req.body)
      end
    end

    def format(cwid)
      cwid.to_s.split('-').join('')
    end

    def connection
      Faraday.new(url: self.configuration.base_url) do |f|
        f.response :xml, :content_type => /\bxml$/
        f.adapter :net_http
        f.basic_auth self.configuration.username, self.configuration.password
      end
    end
  end
end
