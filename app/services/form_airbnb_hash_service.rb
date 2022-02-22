class FormAirbnbHashService
  include BaseService

  def initialize(airbnb_params)
    @airbnb_params = airbnb_params
  end

  def call
    success(to_model_hash)
  end

  private

  def to_model_hash
    {
      reservation: get_reservation_hash,
      guest: get_guest_hash
    }
  end

  def get_reservation_hash
    {
      code: @airbnb_params[:code],
      start_date: @airbnb_params[:start_date],
      end_date: @airbnb_params[:end_date],
      payout_price: @airbnb_params[:expected_payout_amount],
      adults: @airbnb_params[:guest_details][:number_of_adults],
      children: @airbnb_params[:guest_details][:number_of_children],
      infants: @airbnb_params[:guest_details][:number_of_infants],
      guests: @airbnb_params[:number_of_guests],
      security_price: @airbnb_params[:listing_security_price_accurate],
      currency: @airbnb_params[:host_currency],
      nights: @airbnb_params[:nights],
      status: @airbnb_params[:status_type],
      total_price: @airbnb_params[:total_paid_amount_accurate]
    }
  end

  def get_guest_hash
    {
      email: @airbnb_params[:guest_email],
      first_name: @airbnb_params[:guest_first_name],
      last_name: @airbnb_params[:guest_last_name],
      phone: @airbnb_params[:guest_phone_numbers] # array of numbers
    }
  end
end