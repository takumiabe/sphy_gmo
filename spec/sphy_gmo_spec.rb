require 'spec_helper'

describe SphyGmo do
  it 'has a version number' do
    expect(SphyGmo::VERSION).not_to be nil
  end

  describe '.configure' do
    let(:configs) { {
        host: 'http://host',
        site_id: '123456789',
        site_pass: 'secret',
        shop_id: '987654321',
        shop_pass: 'opensesame'
      } }
    before do
      SphyGmo.configure do |config|
        configs.each_pair { |k,v| config.send("#{k}=", v) }
      end
    end

    subject { SphyGmo.configuration }

    it { is_expected.to have_attributes(configs) }

    describe ".configuration" do
      %i[host site_id site_pass shop_id shop_pass].each do |k|
        describe "[:#{k}]" do
          it { expect(SphyGmo.configuration[k]).to eq(configs[k]) }
        end
      end
    end
  end
end
