class ParseResponseService
  include BaseService

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    if parse_params.success?
      success(parse_params.response)
    else
      fail(parse_params.error)
    end
  end

  private

  def parse_params
    @response ||=
      if params[:reservation].present? && params[:reservation].is_a?(Hash)
        # assuming it is params format of AirBnB
        FormAirbnbHashService.call(params[:reservation])
      elsif params[:reservation_code].present?
        # assuming it is params format for Booking
        FormBookingHashService.call(params)
      else
        fail("Format not found")
      end
  end
end