# frozen_string_literal: true

module ActiveRecord
  class QueryObject
    class Null < QueryObject
      def merge(query)
        query
      end

      def query
        []
      end
    end
  end
end
