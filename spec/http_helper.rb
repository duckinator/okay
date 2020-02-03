require "okay/http"

def define_helper(name)
  # TODO: Avoid using the production server on CI.
  host =
    if ENV["CI"]
      "https://httpbin.org"
    else
      "http://localhost"
    end

  define_method(name) { |url, *args|
    Okay::HTTP.send(name, "#{host}#{url}", *args)
  }
end

%w[
  delete
  get
  head
  options
  patch
  post
  put
  trace
].each do |name|
  define_helper name
end
