# frozen_string_literal: true

module ActiveRecord
  class QueryObject
    class UnableToComposeQueries < StandardError
      def initialize(query, other)
        super(
          <<~MESSAGE
            Unable to compose queries #{query.class.name} and
            #{other.class.name}. You cannot compose queries where #query
            returns an ActiveRecord::Relation in one and an array in the other.
          MESSAGE
        )
      end
    end
  end
end
