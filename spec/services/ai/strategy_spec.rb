require 'rails_helper'

RSpec.describe Ai::Strategy do
  let(:prompt) { "Sample prompt" }

  describe '#call' do
    context 'when AI is GROQ' do
      let(:ai) { Ai::Groq::NAME }
      let(:ai_strategy) { described_class.new(ai, prompt) }

      it 'calls Ai::Groq with the prompt' do
        expect(Ai::Groq).to receive(:new).with(prompt).and_return(double(call: { result: 'some result' }))
        result = ai_strategy.call
        expect(result).to eq({ result: 'some result' })
      end
    end

    context 'when AI is CLAUDE' do
      let(:ai) { Ai::Claude::NAME }
      let(:ai_strategy) { described_class.new(ai, prompt) }

      it 'calls Ai::Claude with the prompt' do
        expect(Ai::Claude).to receive(:new).with(prompt).and_return(double(call: { result: 'some result' }))
        result = ai_strategy.call
        expect(result).to eq({ result: 'some result' })
      end
    end

    context 'when AI is OPENAI' do
      let(:ai) { Ai::Openai::NAME }
      let(:ai_strategy) { described_class.new(ai, prompt) }

      it 'calls Ai::Openai with the prompt' do
        expect(Ai::Openai).to receive(:new).with(prompt).and_return(double(call: { result: 'some result' }))
        result = ai_strategy.call
        expect(result).to eq({ result: 'some result' })
      end
    end

    context 'when AI is unknown' do
      let(:ai) { 'UNKNOWN_AI' }
      let(:ai_strategy) { described_class.new(ai, prompt) }

      it 'returns an error message' do
        result = ai_strategy.call
        expect(result).to eq({ error: "AI not found" })
      end
    end
  end
end
