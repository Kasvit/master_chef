Groq.configure do |config|
  config.api_key = ENV["GROQ_API_KEY"]
  config.model_id = "llama-3.1-70b-versatile"
end
