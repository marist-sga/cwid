module CWID
  # Configure with Gem with Configuration!
  class Configuration
    attr_accessor :base_url, :search_path, :username, :password

    # Create a new Configuration instance.
    #
    # @return [CWID::Configuration] A Configuration instance with just the @base_url and @search_path set.
    def initialize
      @base_url = 'http://genweb3.it.marist.edu'
      @search_path = '/ldapxml/ldapxml.php?search='
    end
  end
end
