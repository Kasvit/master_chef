# frozen_string_literal: true

class Ai::Strategy
  attr_reader :ai, :prompt

  def initialize(ai, prompt)
    @ai = ai
    @prompt = prompt
  end

  def call
    case @ai
    when Ai::Groq::NAME
      Ai::Groq.new(@prompt).call
    when Ai::Claude::NAME
      Ai::Claude.new(@prompt).call
    when Ai::Openai::NAME
      Ai::Openai.new(@prompt).call
    else
      { error: "AI not found" }
    end
  end
end
