# frozen_string_literal: true

RSpec.describe ActiveRecord::QueryObject do
  it 'has a version number' do
    expect(ActiveRecord::QueryObject::VERSION).not_to be nil
  end
end
