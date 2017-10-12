require 'openssl/better_defaults'
require 'net/https'

class Okay
  module HTTP
    RedirectLimitError = Class.new(StandardError)

    DEFAULT_REDIRECT_LIMIT = 10

    # Make an HTTP GET request.
    #
    # @param url [String] The URL to request.
    # @param parameters [Hash] A hash representing a query string.
    def self.get(url, parameters: {})
      send_request(:Get, url, parameters, nil)
    end

    # Make an HTTP POST request.
    #
    # @param url [String] The URL to request.
    # @param data [String] Raw data to for the body of the request.
    # @param form_data [Hash] Data for the request body, encoded as though it
    #   were a form.
    def self.post(url, data: nil, form_data: nil)
      if !data.nil? && !form_data.nil?
        raise ArgumentError, "cannot specify data and form_data arguments simultaneously."
      end

      if form_data.nil?
        body = data
      else
        body = URI.encode_www_form(form_data)
      end

      send_request(:Post, url, nil, body)
    end

    # Helper method for actually creating a request.
    #
    # @param http_method [Symbol] A symbol representing the class name for
    #   +Net::HTTP+. E.g., +:Get+ for GET requests, +:Post+ for POST, etc.
    # @param url [String] URL for the request.
    # @param parameters [Hash, nil] Request parameters (for the query string).
    # @param body [String, nil] Request body.
    # @param redirect_limit [Numeric] The maximum number of redirects allowed
    def self.send_request(http_method, url, parameters, body, redirect_limit = DEFAULT_REDIRECT_LIMIT)
      if redirect_limit <= 0
        raise RedirectLimitError, "request exceeded redirect limit"
      end

      # Convert the URL (a String) into a URI object.
      uri = URI.parse(url)

      # Set the query string for the request.
      uri.query = URI.encode_www_form(parameters) unless parameters.nil?

      options = {
        # If the URI starts with "https://", enable SSL/TLS.
        use_ssl: (uri.scheme == 'https')
      }

      # Net::HTTP.start() keeps a connection to the host alive
      # for all requests that occur inside the block.
      Net::HTTP.start(uri.host, uri.port, options) do |http|
        # Get a reference to the class for the specified request type.
        # E.g., if it's a post request, this returns Net::HTTP::Post.
        request_class = Net::HTTP.const_get(http_method)

        # Create the request object, but don't send it.
        request  = request_class.new(uri)
        # Set the request body, if there is one.
        request.body = body unless body.nil?

        # Send the request, storing the result in +response+.
        response = http.request(request)

        # Handle responses.
        case response
        when Net::HTTPSuccess
          # Request succeeded; return the result.
          response
        when Net::HTTPRedirection
          # Follow a redirect.
          # Decrements +redirect_limit+ while doing so, to avoid redirect loops.
          # NOTE: Does not handle HTTP 307. https://httpstatuses.com/307
          send_request(:Get, response['location'], parameters, body, redirect_limit - 1)
        else
          # +response.value+ raises an exception if the request isn't successful.
          response.value
        end
      end
    end

    # Make +send_request+ a private method.
    private_class_method :send_request
  end
end
