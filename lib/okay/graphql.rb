require "okay/version"

module Okay
  class GraphQL
    Container = Struct.new(:value) do
      def inspect
        value
      end
    end

    class QueryDSL
      def initialize(indent = 0, &query)
        @query = ""
        @indent = indent
        @indent_str = " " * indent
        instance_exec(&query)
      end

      def method_missing(name, *args, **kwargs, &block)
        query_part = @indent_str + name.to_s
        if args.length > 0 || kwargs.length > 0
          query_part += "("

          query_args = []
          query_args += args unless args.empty?
          query_args += kwargs.map { |k,v|
            [k,v.inspect].join(": ")
          }
          query_part += query_args.join(", ")

          query_part += ")"
        end

        if block
          query_part += " {\n"
          query_part += QueryDSL.new(@indent + 2, &block).to_s
          query_part += @indent_str + "}"
        end

        @query += "#{query_part}\n"
      end

      def to_s
        @query
      end
    end

    class Query
      def initialize(&query)
        @query = QueryDSL.new(&query)
      end

      def to_s
        "query {\n" +
          @query.to_s.gsub(/^/, "  ") +
        "}"
      end
    end

    def self.query(&query_)
      Query.new(&query_)
    end
  end
end

class Object
  def self.const_missing(name)
    # HACK: if const_missing is called inside Okay::GraphQL#initialize,
    #       we wrap the constant name in a GraphQL::Container.
    #       Otherwise, we re-raise the exception.
    if caller[2] =~ /^#{Regexp.escape(__FILE__)}:\d+:in `initialize'$/
      Okay::GraphQL::Container.new(name.to_s)
    else
      # Create an exception equivalent to what's normally raised.
      exception = NameError.new("uninitialized constant #{name.to_s}")

      # Preserve the backtrace.
      exception.set_backtrace(caller)

      # Raise the exception.
      raise exception
    end
  end
end

puts Okay::GraphQL.query {
  repository(owner:"octocat", name:"Hello-World") {
    issues(last:20, states:CLOSED) {
      edges {
        node {
          title
          url
          labels(first:5) {
            edges {
              node {
                name
              }
            }
          }
        }
      }
    }
  }
}
