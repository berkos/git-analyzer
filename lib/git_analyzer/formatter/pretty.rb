require 'rainbow/refinement'

module GitAnalyzer
  module Formatter
    module Pretty
      using Rainbow
      BAR_LENGTH = 80
      CHAR = '█'

      class << self
        def write(data)
          return puts "No Commits found".red if data.empty?

          top_committer_commits = data.first[:commits]

          output = []
          data.each do |row|
            output << generate_row(row, top_committer_commits)
          end

          puts output
        end

        private

        def generate_row(row, top_commiter_commits)
          "#{(CHAR * ((row[:commits] / top_commiter_commits.to_f) * BAR_LENGTH)).green} #{row[:name]} (#{row[:email].blue}) -> #{row[:commits].to_s.red} commits (#{row[:contribution_percentage]}% contribution)"
        end
      end
    end
  end
end
