# Okay

Okay provides implementations of common utilities in Ruby which aim to
prioritize the ability to understand the code, at the expense of being
less full-featured than more specialized alternatives.

Goals:

* Concise, but easy-to-understand code.
* Be reasonably robust, but don't chase every potential edgecase. Handle
  them as they come.
* Well-documented codebase.
  * Document known limitations, not just features.
  * Document tests, not just the implementation.
* Thorough, easily-understood tests.

The choices of what utilities to implement and how to implement them is
inherently _extremely_ subjective, and prone to changing depending on
real-world use and feedback. Be sure to take a glance at the relevant code
or ask questions if you aren't sure it'll work for your usecase.

If it doesn't, I may decide I want to add support for it, or be able to
help you find something that works for you!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'okay'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install okay

## Usage

### HTTP

* `GET` and `POST` requests supported.
* TLS is used automatically for HTTPS URLs.
* Does not handle HTTP 307 redirects correctly. (Because it changes it to a GET
  request.)

```ruby
require 'okay/http'

Okay::HTTP.get("https://smallest.dog") #=> #<Net::HTTPOK 200 OK readbody=true>
Okay::HTTP.get("https://smallest.dog").body # => returns the page contents.

# Generates a query string based on +parameters+, ultimately requesting
# https://httpbin.org/get?foo=bar
Okay::HTTP.get("https://httpbin.org/get", parameters: { "foo" => "bar" })

# Encodes +form_data+ as though it were a form, and sets the result of
# that as the request body.
Okay::HTTP.post("https://httpbin.org/post", form_data: { "foo" => "bar" })

# Uses +data+ as the request body.
Okay::HTTP.post("https://httpbin.org/post", data: "hello, world!")
```

### GraphQL DSL

```ruby
require "okay/graphql"

query = GraphQL.query {
    viewer {
        login
    }
}

response = request.submit!(:github, {bearer_token: ENV["DEMO_GITHUB_TOKEN"]})
response.body.from_json
# =>
#   {"data" =>
#     {"viewer" =>
#       {"login" => "duckinator"}}}
```

### Raw GraphQL Queries

There are cases where the DSL is more of a hindrance than help, e.g. if
you need to use `@filter` or similar. For those cases, you can use raw
queries:

```ruby
require "okay/graphql"

query = GraphQL.query <<~QUERY
    viewer {
        login
    }
QUERY

response = request.submit!(:github, {bearer_token: ENV["DEMO_GITHUB_TOKEN"]})
response.body.from_json
# =>
#   {"data" =>
#     {"viewer" =>
#       {"login" => "duckinator"}}}

```

### Template Engine

Okay also provides a basic templating engine.

It is literally just a wrapper around `Kernel.format()` and `Pathname`.

Assuming a `./templates/example.html` containing: `a %{foo} c %{bar} e`

```ruby
require "okay/template"

template = Okay::Template.new("./templates/")
template.apply("example.html", {foo: "b", bar: "d"}) #=> "a b c d e"
```

### SimpleOpts (OptionParser improvements)

See the [example usage in
HowIs](https://github.com/how-is/how_is/blob/ad81620/lib/how_is/cli.rb#L39-L74).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/duckinator/okay. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Okay project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/duckinator/okay/blob/master/CODE_OF_CONDUCT.md).
