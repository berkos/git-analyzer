require_relative "analyzer/version"
require 'date'
require 'pry'

module Git
  module Analyzer
    class << self
      def contributors(period: nil)
        since = generate_since_day(period)

        result = `git shortlog -sne#{" --since='#{since}'" unless period.nil?}`
        result = result.scan(/(\d+)\t(.+)\<(.+)\>/)
        total_commits = result.sum { |array| array.first.to_i }

        contributors = result.map do |array|
          {
            commits: array[0].to_i,
            contribution_percentage: ((array.shift.to_f / total_commits) * 100).floor(2),
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
end
