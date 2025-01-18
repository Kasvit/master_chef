# frozen_string_literal: true

class Ai::Base
  attr_reader :prompt

  def initialize(prompt)
    @prompt = prompt
  end

  def call
    raise "Not implemented"
  end
end
