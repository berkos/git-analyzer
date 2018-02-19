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
        \e[32m████████████████████████████████████████████████████████████████████████████████\e[0m John smith (\e[34mjohn@smith.com \e[0m) -> \e[31m749\e[0m commits (91.11% contribution)
        \e[32m███████\e[0m Angela Fine (\e[34mangela@fine.com\e[0m) -> \e[31m69\e[0m commits (8.39% contribution)
        \e[32m\e[0m Marcus Kruz (\e[34mmarcus@kruz.com\e[0m) -> \e[31m4\e[0m commits (0.48% contribution)
      HEREDOC
    end

    it 'prints the correct output' do
      expect { subject }.to output(expected_output).to_stdout
      # subject
    end

    context 'when data is empty' do
      let(:data) { [] }

      it 'prints "No Commits found"' do
        expect { subject }.to output("\e[31mNo Commits found\e[0m\n").to_stdout
      end
    end
  end
end
