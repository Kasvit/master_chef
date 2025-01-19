class Rack::Attack
  throttle("requests/ip", limit: 60, period: 1.minute) do |req|
    req.ip
  end
end
