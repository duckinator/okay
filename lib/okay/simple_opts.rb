# frozen_string_literal: true

require "okay/version"
require "optparse"

module Okay
  ##
  # An OptionParser wrapper providing a few convenience functions.
  class SimpleOpts < OptionParser
    def initialize(*args, defaults: nil)
      super(*args)
      @okay_options = defaults || {}
    end

    # simple(..., :a)
    # simple(..., :b)
    #   ==
    # options = {}
    # on(...) { |val| options[:a] = val }
    # on(...) { |val| options[:b] = val }
    def simple(*args)
      key = args.pop
      on(*args) { |*x| @okay_options[key] = x[0] }
    end

    def parse(args)
      parse!(args.dup)
      @okay_options
    end
  end
end
