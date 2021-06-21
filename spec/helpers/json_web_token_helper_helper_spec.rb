require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the JsonWebTokenHelperHelper. For example:
#
# describe JsonWebTokenHelperHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe JsonWebTokenHelper, type: :helper do
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
