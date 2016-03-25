require 'rails_helper'

RSpec.describe ApiConstraints do
  let(:api_v1) { ApiConstraints.new(version: 1) }
  let(:api_v2) { ApiConstraints.new(version: 2, default: true) }

  describe '#matches?' do
    context "when the version matches the 'Accept' header" do
      let(:request) { double(host: 'api.orders.dev',
                        headers: {'Accept' => 'application/vnd.orders.v1'}) }
      it 'returns true' do
        expect(api_v1.matches?(request)).to be true
      end
    end

    context 'when the default option is specified' do
      let(:request) { double(host: 'api.orders.dev') }

      it 'returns the default version' do
        expect(api_v2.matches?(request)).to be true
      end
    end
  end
end
