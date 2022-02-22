class FormBookingHashService
  include BaseService

  def initialize(booking_params)
    @booking_params = booking_params
  end

  def call
    success(to_model_hash)
  end

  private

  def to_model_hash
    @guest_hash = @booking_params[:guest]
    code = @booking_params[:reservation_code]
    @booking_params.delete(:guest)
    @booking_params.delete(:reservation_code)
    {
      reservation: reservation_params.merge!(code: code).to_h.symbolize_keys,
      guest: guest_params.to_h.symbolize_keys
    }
  end

  def reservation_params
    @booking_params.permit(
      :start_date, :end_date, :nights, :children, :guests, :adults,
      :infants, :status, :total_price, :currency, :payout_price, :security_price
    )
  end

  def guest_params
    @guest_hash.permit(
      :first_name, :last_name, :email, :phone
    )
  end
end