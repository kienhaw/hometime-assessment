class Api::ReservationsController < ApplicationController
  def custom_update
    # the purpose parsing service is to reformat the payload into serializble hash
    # and mapped to the database columns correctly
    # in order to do smth like e.g. -> reservation.update(params)
    parsed_response = ::ParseResponseService.new(params).call
    if parsed_response.success?
      reservation_params = parsed_response.response[:reservation]
      f_reservation = Reservation.find_by(code: reservation_params[:code])
      guest_params = parsed_response.response[:guest]
      @guest = if f_reservation
                f_reservation.guest
              else
                Guest.find_or_create_by!(email: guest_params[:email])
              end

      @guest.first_name = guest_params[:first_name]
      @guest.last_name = guest_params[:last_name]
      @guest.phone = populate_phone_array(guest_params[:phone])

      if @guest.save
        reservation = @guest.reservations.find_or_create_by!(code: reservation_params[:code])
        if reservation.update(reservation_params)
          render json: { message: "OK" }, status: 200
        else
          render json: { message: reservation.errors }, status: 422
        end
      else
        render json: { message: @guest.errors }, status: 422
      end
    else
      render json: { code: 422, message: parsed_response.error }, status: 422
    end
  end

  def populate_phone_array(phone)
    # form array of phone numbers
    # even if the phone value is a string
    val = @guest.phone
    if val.is_a?(Array)
      val << if phone.is_a?(Array)
              phone.map &:trim
            else
              phone
            end
    elsif val.is_a?(String)
      val = [val, phone]
    end
    val.uniq
  end
end
