require 'openssl/better_defaults'
require 'net/https'

class Okay
  module HTTP
    RedirectLimitError = Class.new(StandardError)

    DEFAULT_REDIRECT_LIMIT = 10

    # A mapping of HTTP request methods to Net::HTTP methods.
    # (Yay overlapping terminology.)
    #
    # Also, what are consistent APIs even?
    METHODS = {
      get:  'get_response',
      post: 'post_form',
    }

    def self.get(url, parameters = {})
      send_request(METHODS[:get], url, parameters)
    end

    def self.post(url, parameters = {})
      send_request(METHODS[:post], url, parameters)
    end

    private

    def self.send_request(http_method, url, parameters, limit = DEFAULT_REDIRECT_LIMIT)
      if limit <= 0
        raise RedirectLimitError, "request exceeded redirect limit"
      end

      uri = URI.parse(url)
      uri.query = URI.encode_www_form(parameters)

      options = { use_ssl: (uri.scheme == 'https') }

      Net::HTTP.start(uri.host, uri.port, options) do |http|
        response = Net::HTTP.send(http_method, uri)

        case response
        when Net::HTTPSuccess
          response
        when Net::HTTPRedirection
          send_request(METHODS[:get], response['location'], parameters, limit - 1)
        else
          # This seemingly-innocent method raises an exception if the request
          # isn't successful.
          response.value
        end
      end
    end
  end
end
