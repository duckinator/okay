require "okay/http"

def define_helper(name)
  define_method(name) { |url, *args|
    Okay::HTTP.send(name, "http://localhost#{url}", *args)
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
