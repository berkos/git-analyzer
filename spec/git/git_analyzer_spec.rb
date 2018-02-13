# frozen_string_literal: true
RSpec.describe GitAnalyzer do
  describe '.contributors' do
    subject { described_class.contributors(period: period) }

    let(:period) { nil }
    let(:command_output) do
      <<~HEREDOC
        749\tJohn smith <john@smith.com >
         69\tAngela Fine <angela@fine.com>
          4\tMarcus Kruz <marcus@kruz.com>
      HEREDOC
    end

    it 'returns a sorted array of hashes with the expected keys' do
      expect(subject).to eq(
        [
          { commits: 749, contribution_percentage: 91.11, name: 'John smith', email: 'john@smith.com ' },
          { commits: 69, contribution_percentage: 8.39, name: 'Angela Fine', email: 'angela@fine.com' },
          { commits: 4, contribution_percentage: 0.48, name: 'Marcus Kruz', email: 'marcus@kruz.com' }
        ]
      )
    end

    before do
      allow(described_class).to receive(:`).and_return(command_output)
    end

    context 'when period is nil' do
      it 'calls shortlog with the correct arguments' do
        expect(described_class).to receive(:`).with('git shortlog -sne')

        subject
      end
    end

    context 'when period is :last_week' do
      let(:period) { :last_week }

      it 'calls shortlog with the correct arguments' do
        ::Timecop.freeze("July 20, 2018") do
          expect(described_class).to receive(:`).with("git shortlog -sne --since='#{DateTime.now - 7}'")

          subject
        end
      end
    end

    context 'when period is :last_month' do
      let(:period) { :last_month }

      it 'calls shortlog with the correct arguments' do
        ::Timecop.freeze("July 20, 2018") do
          expect(described_class).to receive(:`).with("git shortlog -sne --since='#{DateTime.now << 1}'")

          subject
        end
      end
    end
  end
end
