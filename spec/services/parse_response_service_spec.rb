require 'rails_helper'

RSpec.describe ParseResponseService do
  subject { described_class.new(params) }

  describe 'payload #1' do
    let(:params) do
      {
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
      }
    end

    it "should call FormBookingHashService to parse the payload format" do
      expect(FormBookingHashService).to receive(:call).and_return(double(success?: true, response: "Success"))
      subject.call
    end
  end

  describe 'payload #2' do
    let(:params) do
      {
        "reservation": {
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
      }
    end

    it "should call FormAirbnbHashService to parse the payload format" do
      expect(FormAirbnbHashService).to receive(:call).and_return(double(success?: true, response: "Success"))
      subject.call
    end
  end

  describe 'undefined payload format' do
    let(:params) do
      {
        "data": {
          "reservation_code": "XXX12345678"
        }
      }
    end
    let(:service_result) { ServiceResult.new(success: false, response: { error: 'Format not found' }) }

    it "should raise error" do
      expect(subject.call).to eq service_result
    end
  end
end