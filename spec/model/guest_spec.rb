require 'rails_helper'

RSpec.describe Guest, type: :model do
  subject { Guest.create(email: "test@test.com") }

  describe 'validates unique' do
    context 'when email does\'s not exists' do
      it 'should create successfully' do
        expect { subject }.to change(Guest, :count).by(1)
      end
    end

    context 'when email exists?' do
      before { Guest.create(email: "test@test.com") }

      it 'return ActiveRecord::RecordNotUnique' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotUnique, /duplicate key value violates/)
      end
    end
  end
end