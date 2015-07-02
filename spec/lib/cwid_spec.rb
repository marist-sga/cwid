require 'spec_helper'

describe CWID do
  describe '.configure' do
    let(:config) do
      c = CWID.configure do |c|
        c.username = 'dennismurray'
        c.password = 'redfox'
      end
    end

    it { expect(config).to be_an_instance_of CWID::Configuration }
    it { expect(config.base_url).to eql 'http://genweb3.it.marist.edu' }
    it { expect(config.search_path).to eql '/ldapxml/ldapxml.php?search=' }
    it { expect(config.username).to eql 'dennismurray' }
    it { expect(config.password).to eql 'redfox' }
  end

  describe '.format' do
    context 'removes hyphens' do
      let(:formatted) do
        CWID.format('200-45-405')
      end

      it { expect(formatted).to eql '20045405' }
    end

    context 'removes extraneous characters' do
      let(:formatted) do
        CWID.format('&200-45-405;?')
      end

      it { expect(formatted).to eql '20045405' }
    end

    context 'removes the card code' do
      let(:formatted) do
        CWID.format('200454051')
      end

      it { expect(formatted).to eql '20045405' }
    end

    context 'removes spaces' do
      let(:formatted) do
        CWID.format('   200 45 405  ')
      end

      it { expect(formatted).to eql '20045405' }
    end
  end

  describe '.lookup' do
    let(:lookup) do
      VCR.use_cassette 'cwid/lookup', match_requests_on: [:path] do
        CWID.lookup(cwid: '20045405')
      end
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
