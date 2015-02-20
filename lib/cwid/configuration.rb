module CWID
  class Configuration
    attr_accessor :base_url, :search_path, :username, :password

    def initialize
      @base_url = 'http://genweb3.it.marist.edu'
      @search_path = '/ldapxml/ldapxml.php?search='
    end
  end
end
