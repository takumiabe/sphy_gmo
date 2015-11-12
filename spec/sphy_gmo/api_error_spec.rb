require 'spec_helper'

describe SphyGmo::APIError do

  # it { expect(SphyGmo::ErrorInfo.all.size).to eq 236 }
  let(:err) { SphyGmo::ErrorInfo.all.values.sample(3) }

  subject(:api_error) { SphyGmo::APIError.new(err.map(&:info)) }

  describe '#message' do
    subject { api_error.message }
    it { is_expected.to eq err.map(&:message).join(' ') }
  end
  describe '#messages' do
    subject { api_error.messages }
    it { is_expected.to eq err.map(&:message) }
  end

  describe '#raw_errinfo' do
    subject { api_error.raw_errinfo }
    it { is_expected.to eq err.map(&:info).join('|') }
  end

  describe '#raw_errcode' do
    subject { api_error.raw_errcode }
    it { is_expected.to eq err.map(&:code).join('|') }
  end

  describe '#inspect' do
    subject { api_error.inspect }
    it { is_expected.to match api_error.class.name }
    it { is_expected.to match api_error.object_id.to_s }
    it do
      api_error.messages.each do |mes|
        is_expected.to match mes
      end
    end
  end
end
