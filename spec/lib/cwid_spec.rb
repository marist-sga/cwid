require 'spec_helper'

describe CWID do
  describe '.configure' do
    let(:configuration) do
      c = CWID.configure do |c|
        c.username = 'dennismurray'
        c.password = 'redfox'
      end
    end

    it { expect(configuration).to be_an_instance_of CWID::Configuration }
    it { expect(configuration.base_url).to eql 'http://genweb3.it.marist.edu' }
    it { expect(configuration.search_path).to eql '/ldapxml/ldapxml.php?search=' }
    it { expect(configuration.username).to eql 'dennismurray' }
    it { expect(configuration.password).to eql 'redfox' }
  end

  describe '.format' do
    context 'removes hyphens' do
      let(:formatted) do
        CWID.format('200-45-405')
      end

      it { expect(formatted).to eql '20045405' }
    end
  end

  describe '.lookup' do
    let(:lookup) do
      VCR.use_cassette 'cwid/lookup', match_requests_on: [:path] do
        @look = CWID.lookup(cwid: '20045405')
      end

      @look
    end

    it { expect(lookup).to be_an_instance_of Array }
    it { expect(lookup.first).to be_an_instance_of CWID::Person }
    it { expect(lookup.first.email).to eql 'Ethan.Turkeltaub1@marist.edu' }
  end

  describe '.connection' do
    let(:connection) do
      CWID.connection
    end

    it { expect(connection).to be_an_instance_of Faraday::Connection }
  end
end
