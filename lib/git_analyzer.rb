require_relative 'git_analyzer/formatter/csv'
require_relative 'git_analyzer/formatter/pretty'
require_relative 'git_analyzer/version'

require 'date'
require 'pry'

module GitAnalyzer
  class << self
    def contributors(period: nil)
      since = generate_since_day(period)

      result = `git shortlog -sne#{" --since='#{since}'" unless period.nil?}`

      # No commits
      return [] if result == ""

      result = result.scan(/(\d+)\t(.+)\<(.+)\>/)
      total_commits = result.inject(0) { |sum, el| sum + el[0].to_i }

      contributors = result.map do |array|
        {
          commits: array[0].to_i,
          # floor(n) is not available in Ruby < 2.3, multiply by 10000 and then divide by 100 to keep to decimals
          contribution_percentage: (array.shift.to_f / total_commits * 10_000).floor.to_f / 100,
          name: array.shift.strip,
          email: array.shift
        }
      end
    end

    private

    def generate_since_day(period)
      case period
      when :last_week
        DateTime.now - 7
      when :last_month
        DateTime.now << 1
      end
    end
  end
end
