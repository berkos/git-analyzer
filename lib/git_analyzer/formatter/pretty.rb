module GitAnalyzer
  module Formatter
    module Pretty
      BAR_LENGTH = 80
      CHAR = '█'

      class << self
        def write(data)
          return puts "No Commits found" if data.empty?

          top_commiter_commits = data.first[:commits]

          output = []
          data.each do |row|
            output << generate_row(row, top_commiter_commits)
          end

          puts output
        end

        private

        def generate_row(row, top_commiter_commits)
          "#{CHAR * ((row[:commits]/top_commiter_commits.to_f) * BAR_LENGTH)} #{row[:name]||row[:email]} -> #{row[:commits]} commits (#{row[:contribution_percentage]}% contribution)"
        end
      end
    end
  end
end
