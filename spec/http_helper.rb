# frozen_string_literal: true

require "okay/http"

def define_helper(name)
  # TODO: Avoid using the production server on CI.
  host =
    if ENV["CI"]
      "https://httpbingo.org"
    else
      "http://localhost"
    end

  define_method(name) { |url, *args|
    Okay::HTTP.send(name, "#{host}#{url}", *args)
  }
end

[
  "delete",
  "get",
  "head",
  "options",
  "patch",
  "post",
  "put",
  "trace",
].each do |name|
  define_helper name
end
