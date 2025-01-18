RailsRateLimit.configure do |config|
  config.default_store = :memory
  config.default_on_controller_exceeded = -> {
    render json: {
      error: "Too many requests"
    }, status: :too_many_requests
  }
end
