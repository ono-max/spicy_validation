# SpicyValidation

Generate validation methods automatically from database schema.

**[important notice]** Your model file will be overwritten!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spicy_validation'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install spicy_validation

## Usage

1. Run `validation:generate` task
2. Type a number you would like to generate validation
```shell
% rails validation:generate
[warning] If you generate validation, model files will be overwritten.
{:"0"=>"samples", :"1"=>"users"}
Type a number you wanna generate validation > ex) 0
```

## Example

```ruby
# db/migrate/20210227054155_create_users.rb
class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :message, null: true
      t.integer :age, null: false
      t.integer :score
      t.boolean :premium
      t.timestamps
    end
    add_index  :users, [:age, :name], unique: true
  end
end

# app/models/user.rb
class User < ApplicationRecord

  validates :message, presence: true
  validates :age, numericality: true
  validates :score, presence: true, numericality: true, allow_nil: true
  validates :premium, presence: true
  validates_uniqueness_of :age, scope: :name
end


```
## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/spicy_validation. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/spicy_validation/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SpicyValidation project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/spicy_validation/blob/master/CODE_OF_CONDUCT.md).

## Reference

https://github.com/sinsoku/pretty_validation
