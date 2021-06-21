require 'rails_helper'

RSpec.describe JsonWebTokenHelper do
  context "Encoding and Decoding" do
    it 'should encode' do
      expect { JsonWebTokenHelper.encode(user_id: '123') }.to_not raise_error
    end

    it 'should decode' do
      token = JsonWebTokenHelper.encode(user_id: '123')
      decoded = JsonWebTokenHelper.decode(token)
      expect(decoded.keys).to include('user_id')
      expect(decoded['user_id']).to eql('123')
    end
  end
end
