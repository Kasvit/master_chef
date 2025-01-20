# frozen_string_literal: true

class Ai::Openai < Ai::Base
  def call
    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [ { role: "user", content: prompt } ],
        temperature: 0.7
      }
    )
    parsed_response(response)
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end

  def parsed_response(response)
    JSON.parse(response.dig("choices", 0, "message", "content").gsub(/```json\n|```/, ""))
  end
end
