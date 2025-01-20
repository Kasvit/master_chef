# frozen_string_literal: true

class Ai::Claude < Ai::Base
  NAME = "claude".freeze

  def call
    response = client.messages(
      parameters: {
        model: "claude-3-haiku-20240307",
        messages: [
          { "role": "user", "content": prompt },
          { "role": "assistant", "content": "type => JSON" }
        ],
        max_tokens: 1000
      }
    )
    parsed_response(response)
  end

  private

  def client
    @client ||= Anthropic::Client.new
  end

  def parsed_response(response)
    JSON.parse(response["content"].first["text"].gsub(/```json\n|```/, ""))
  end
end
