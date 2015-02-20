module CWID
  class Person
    attr_accessor :name, :surname, :phone, :mailbox, :email, :cwid, :type

    def initialize(hsh)
      person = hsh['directory']['person']

      @name = person['name'].split(' ').first
      @surname = person['lastname']
      @phone = person['phone']
      @mailbox = person['location']
      @email = person['email']
      @cwid = person['cwid']
      @type = person['employeetype']
    end
  end
end
