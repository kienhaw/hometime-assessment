require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let!(:guest) { Guest.create(email: "test@test.com") }
  let(:code) { "XXXX1234" }

  subject { Reservation.create!(guest: guest, code: code) }

  describe 'validates unique' do
    context 'when code does\'s not exists' do
      it 'should create successfully' do
        expect { subject }.to change(Reservation, :count).by(1)
      end
    end

    context 'when code exists?' do
      before { Reservation.create(guest: guest, code: code) }

      it 'return ActiveRecord::RecordNotUnique' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotUnique, /duplicate key value violates/)
      end
    end
  end
end