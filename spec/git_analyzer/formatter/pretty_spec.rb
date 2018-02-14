RSpec.describe GitAnalyzer::Formatter::Pretty do
  describe '.write' do
    subject { described_class.write(data) }
    let(:data) do
      [
        { commits: 749, contribution_percentage: 91.11, name: 'John smith', email: 'john@smith.com ' },
        { commits: 69, contribution_percentage: 8.39, name: 'Angela Fine', email: 'angela@fine.com' },
        { commits: 4, contribution_percentage: 0.48, name: 'Marcus Kruz', email: 'marcus@kruz.com' }
      ]
    end

    let(:expected_output) do
      <<~HEREDOC
        ████████████████████████████████████████████████████████████████████████ John smith -> 749 commits (91.11% contribution)
        ██████ Angela Fine -> 69 commits (8.39% contribution)
         Marcus Kruz -> 4 commits (0.48% contribution)
      HEREDOC
    end

    it 'prints the correct output' do
      expect { subject }.to output(expected_output).to_stdout
    end
  end
end
