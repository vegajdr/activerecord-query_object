# frozen_string_literal: true

class ApplicationQuery
  include Enumerable

  class << self
    def merge(*queries)
      queries.reduce(NullQuery.new, :merge)
    end

    def query(params = {}, scope = nil)
      return new(scope, params).query if scope

      new(initial_scope, params).query
    end

    private

    def initial_scope
      return self::RESOURCE.all if defined?(self::RESOURCE)

      ApplicationRecord.none
    end
  end

  def initialize(scope = initial_scope, params = {})
    @params = params
    @scope = scope

    compose
  end

  def query
    scope
  end

  def |(other)
    if relation? && other.relation?
      ApplicationQuery.new(cached_query.merge(other.cached_query))
    elsif eager? && other.eager?
      ApplicationQuery.new(cached_query | other.cached_query)
    else
      raise UnableToComposeQueries.new(self, other)
    end
  end

  alias merge |

  delegate :count,
           :first,
           :each,
           :to_a,
           to: :cached_query

  def exists?
    return cached_query.exists? if relation?

    cached_query.present?
  end

  def none?
    !exists?
  end

  alias to_ary to_a

  def relation?
    cached_query.is_a?(ActiveRecord::Relation)
  end

  def eager?
    cached_query.is_a?(Array)
  end

  def cached_query
    @cached_query ||= query
  end

  private

  def queries
    []
  end

  def compose
    return if queries.blank?

    @scope = self.class.merge(*query_instances).query
  end

  def query_instances
    queries.map { |query| query.new(scope, params) }
  end

  def initial_scope
    klass = self.class
    return klass::RESOURCE.all if defined?(klass::RESOURCE)

    ApplicationRecord.none
  end

  attr_reader :scope, :params
end
