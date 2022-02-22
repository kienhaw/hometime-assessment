require 'rails_helper'

RSpec.describe Api::ReservationsController do
  describe 'POST /api/reservations/update' do
    let(:reservation_hash) do
      {
        code: "YYY12345678",
        start_date: "2021-04-14",
        end_date: "2021-04-18",
        nights: 4,
        guests: 4,
        adults: 2,
        children: 2,
        infants: 0,
        status: "accepted",
        currency: "AUD",
        payout_price: "4200.00",
        security_price: "500",
        total_price: "4700.00"
      }  
    end

    let(:guest_hash) do
      {
        first_name: "Wayne",
        last_name: "Woodbridge",
        phone: "639123456789",
        email: "wayne_woodbridge@bnb.com"
      }
    end

    context 'when creating new record' do
      before do
        service_result = double("ParseResponseService")
        expect(ParseResponseService).to receive(:new).with(any_args).and_return(service_result)
        expect(service_result).to receive(:call).and_return(double(success?: true, response: { reservation: reservation_hash, guest: guest_hash } ))
      end

      it 'should create reservation and guest successfully' do
        expect(Guest.count).to eq 0
        expect(Reservation.count).to eq 0
        post '/api/reservations/update', params: {}
        expect(response.code).to eq '200'
        expect(json["message"]).to eq 'OK'
        expect(Guest.count).to eq 1
        expect(Reservation.count).to eq 1
        expect(Reservation.first.code).to eq reservation_hash[:code]
        expect(Guest.first.first_name).to eq guest_hash[:first_name]
      end
    end
  end
end

def json
  JSON.parse(response.body)
end