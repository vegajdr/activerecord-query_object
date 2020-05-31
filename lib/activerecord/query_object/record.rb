# frozen_string_literal: true

module ActiveRecord
  class QueryObject
    class Record < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
