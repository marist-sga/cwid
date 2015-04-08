module CWID
  class Person
    attr_accessor :first_name, :last_name, :phone, :mailbox, :email, :cwid, :type

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
