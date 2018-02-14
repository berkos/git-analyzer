module GitAnalyzer
  module Formatter
    module Pretty
      BAR_LENGTH = 80
      CHAR = '█'

      class << self
        def write(data)
          output = []
          data.each do |row|
            output << generate_row(row)
          end

          puts output
        end

        private

        def generate_row(row)
          "#{CHAR * (row[:contribution_percentage]/100 * BAR_LENGTH)} #{row[:name]||row[:email]} -> #{row[:commits]} commits (#{row[:contribution_percentage]}% contribution)"
        end
      end
    end
  end
end
