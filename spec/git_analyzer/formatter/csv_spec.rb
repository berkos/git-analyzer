RSpec.describe GitAnalyzer::Formatter::CSV do
  describe '.write' do
    subject { described_class.write(data) }
    let(:data) do
      [
        { cl_1: 'A', cl_2: 'B', cl_3: 'C' },
        { cl_1: 'D', cl_2: 'E', cl_3: 'F' }
      ]
    end

    before do
      # Stub constant so it does not deletes any existing csv
      stub_const("GitAnalyzer::Formatter::CSV::FILE_NAME", 'contributors_spec.csv')
    end


    after do
      FileUtils.rm(described_class::FILE_NAME)
    end

    it 'writes a csv in the correct format' do
      subject

      expect(IO.read(described_class::FILE_NAME)).to eq("cl_1,cl_2,cl_3\nA,B,C\nD,E,F\n")
    end

    context 'when data is empty' do
      let(:data) { [] }

      it 'writes on the csv that no commits found' do
        subject

        expect(IO.read(described_class::FILE_NAME)).to eq("No commits found\n")
      end
    end
  end
end
