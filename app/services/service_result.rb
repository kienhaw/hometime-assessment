class ServiceResult < OpenStruct
  def initialize(success:, response:)
    super(success?: success, response: response)
  end

  def error
    return if success?
    response[:error]
  end

  def error_response(status = 400)
    return if success?

    {
      'errors': [
        {
          'message': error&.respond_to?(:to_s) ? error.to_s : error
        }
      ],
      'status': status
    }
  end
end
