# frozen_string_literal: true

require 'csv'

module GitAnalyzer
  module Formatter
    class CSV
      FILE_NAME = 'contributors.csv'
      class << self
        def write(data)
          ::CSV.open(FILE_NAME, 'wb') do |csv|
            csv << data.first.keys # adds the attributes name on the first line
            data.each do |hash|
              csv << hash.values
            end
          end
        end
      end
    end
  end
end
