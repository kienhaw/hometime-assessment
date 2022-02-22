require 'rails_helper'

RSpec.describe FormBookingHashService do
  subject { described_class.new(params) }

  describe '#call' do
    let(:params) do
      ActionController::Parameters.new(
        "reservation_code": "YYY12345678",
        "start_date": "2021-04-14",
        "end_date": "2021-04-18",
        "nights": 4,
        "guests": 4,
        "adults": 2,
        "children": 2,
        "infants": 0,
        "status": "accepted",
        "guest": {
          "first_name": "Wayne",
          "last_name": "Woodbridge",
          "phone": "639123456789",
          "email": "wayne_woodbridge@bnb.com"
        },
        "currency": "AUD",
        "payout_price": "4200.00",
        "security_price": "500",
        "total_price": "4700.00"
      )
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
      expect(reservation_hash[:adults]).to eq(params[:adults])
      expect(guest_hash.keys).to contain_exactly(:email, :first_name, :last_name, :phone)
      expect(guest_hash[:phone]).to eq("639123456789")
    end
  end
end
