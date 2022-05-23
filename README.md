# ActiveRecord::QueryObject

Provides an object to ergonomically compose active ActiveRecord queries in order to increase readability, reusability and implementation speed by allowing to group queries in a semantic fashion to match business domain logic language


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activerecord-query_object'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install activerecord-query_object

## Usage

The main benefit of using `ActiveRecord::QueryObject` is the provision of an interface that allows for managing active record queries in a semantically organized manner, for example:

### Definition
```ruby
class PostsQuery < ActiveRecord::QueryObject
  RESOURCE = Post # An ActiveRecord::Base class

  def queries
    [
      DefaultScope
    ]
  end

  class DefaultScope < ActiveRecord::QueryObject
    # Allows for easy bypassing of using `default_scope` pitfalls:
    # https://www.ombulabs.com/blog/ruby/rails/best-practices/why-using-default-scope-is-a-bad-idea.html

    def query
      scope
        .preload(:comments)
        .by_descending_date
    end
  end
end

```

We can define a specific query execution through the `#query` method, which is required to return an `ActiveRecord::Relation`.

This is required in order for the defined `#queries` method to chain together each defined query.

Now we can execute the query:

```ruby
PostsQuery.new # -> Returns posts results based on defined DefaultScope
```

### Composition

Building off the previous example we can now see the power of constructing query objects in this manner in order to reuse common logic that may be tied to domain logic:

```ruby
class PostsByAuthorQuery < ActiveRecord::QueryObject
  RESOURCE = Post

  def queries
    [
      PostsQuery,
      ByAuthor
    ]
  end

  class ByAuthor < ActiveRecord::QueryObject
    def query
      scope.where(author: params[:author])
    end
  end
end
```

A query object can optionally take a second hash `params` argument in order to have data passed in as seen in the definition above to executed in this manner:

```ruby
  author = Author.first

  PostsByAuthorQuery.new(author: author)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/activerecord-query_object. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/activerecord-query_object/blob/master/CODE_OF_CONDUCT.md).


## Code of Conduct

Everyone interacting in the ActiveRecord::QueryObject project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/activerecord-query_object/blob/master/CODE_OF_CONDUCT.md).
