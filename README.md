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
2. Type a number that you would like to generate validation
```shell
% rails validation:generate
[warning] If you generate validation, model files will be overwritten.
{:"0"=>"samples", :"1"=>"users"}
Type a number you wanna generate validation > ex) 0
```

## Example

```sql
+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| id         | bigint(20)   | NO   | PRI | NULL    | auto_increment |
| name       | varchar(255) | NO   |     | NULL    |                |
| message    | varchar(255) | YES  |     | NULL    |                |
| age        | int(11)      | NO   |     | NULL    |                |
| score      | int(11)      | YES  |     | NULL    |                |
| premium    | tinyint(1)   | YES  |     | NULL    |                |
| created_at | datetime(6)  | NO   |     | NULL    |                |
| updated_at | datetime(6)  | NO   |     | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
```

```ruby
# app/models/user.rb
class User < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  validates :score, numericality: true, allow_nil: true
end
```

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ono-max/spicy_validation. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ono-max/spicy_validation/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SpicyValidation project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ono-max/spicy_validation/blob/master/CODE_OF_CONDUCT.md).

## Acknowledgement

This repository based on https://github.com/sinsoku/pretty_validation. See the file headers for detail informations.
