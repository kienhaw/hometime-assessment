require 'rails_helper'

RSpec.describe FormAirbnbHashService do
  subject { described_class.new(params) }

  describe '#call' do
    let(:params) do
      {
        "code": "XXX12345678",
        "start_date": "2021-03-12",
        "end_date": "2021-03-16",
        "expected_payout_amount": "3800.00",
        "guest_details": {
          "localized_description": "4 guests",
          "number_of_adults": 2,
          "number_of_children": 2,
          "number_of_infants": 0
        },
        "guest_email": "wayne_woodbridge@bnb.com",
        "guest_first_name": "Wayne",
        "guest_last_name": "Woodbridge",
        "guest_phone_numbers": [
          "639123456789",
          "639123456789"
        ],
        "listing_security_price_accurate": "500.00",
        "host_currency": "AUD",
        "nights": 4,
        "number_of_guests": 4,
        "status_type": "accepted",
        "total_paid_amount_accurate": "4300.00"
      }
    end

    it "should form reservation and guest hash" do
      result = subject.call
      expect(result).to be_success
      reservation_hash = result.response[:reservation]
      guest_hash = result.response[:guest]
      expect(reservation_hash).to be_present
      expect(guest_hash).to be_present
      expect(reservation_hash.keys).to contain_exactly(
        :code, :start_date, :end_date, :payout_price, :adults, :children,
        :infants, :guests, :security_price, :currency, :nights, :status,
        :total_price
      )
      expect(reservation_hash[:adults]).to eq(params[:guest_details][:number_of_adults])
      expect(guest_hash.keys).to contain_exactly(:email, :first_name, :last_name, :phone)
      expect(guest_hash[:phone]).to eq(params[:guest_phone_numbers])
    end
  end
end
