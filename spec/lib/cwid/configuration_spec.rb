require 'spec_helper'

describe CWID::Configuration do
  describe '#initialize' do
    let(:configuration) do
      c = CWID::Configuration.new

      c
    end

    it { expect(configuration).to be_an_instance_of CWID::Configuration }
    it { expect(configuration.base_url).to eql 'http://genweb3.it.marist.edu' }
    it { expect(configuration.search_path).to eql '/ldapxml/ldapxml.php?search=' }
  end
end
