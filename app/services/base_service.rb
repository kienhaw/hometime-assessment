module BaseService
  extend ActiveSupport::Concern

  class_methods do
    def call(*args)
      new(*args).call
    end
  end

  def fail(error)
    ServiceResult.new(success: false, response: { error: error })
  end

  def success(args = {})
    ServiceResult.new(success: true, response: args)
  end

  class Error < StandardError
  end
end
