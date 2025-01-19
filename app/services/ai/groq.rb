# frozen_string_literal: true

class Ai::Groq < Ai::Base

  def call
    puts "Generating recipe with groq"

    response = client.chat(prompt)
    parsed_response(response)
  end

  private

  def client
    @client ||= Groq::Client.new(api_key: ENV['GROQ_API_KEY'])
  end

  def parsed_response(response)
    JSON.parse(response['content'].gsub(/```json\n|```/, ''))
  end
end
