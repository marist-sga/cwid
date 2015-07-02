module CWID
  # A result from the LDAP request.
  class Person
    attr_accessor :first_name, :last_name, :phone, :mailbox, :email, :cwid, :type

    # Create a new Person from an entry.
    #
    # @param  [Hash]         person A hash from the LDAP lookup.
    # @return [CWID::Person]        The new Person!
    def initialize(person)
      @first_name = person['name'].split(' ').first
      @last_name = person['lastname']
      @phone = person['phone']
      @mailbox = person['location']
      @email = person['email']
      @cwid = person['cwid']
      @type = person['employeetype']
    end
  end
end
