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

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SpicyValidation project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ono-max/spicy_validation/blob/master/CODE_OF_CONDUCT.md).

## Acknowledgement

This repository based on https://github.com/sinsoku/pretty_validation. See the file headers for detail informations.
