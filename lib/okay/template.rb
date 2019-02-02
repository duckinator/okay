# frozen_string_literal: true

require "okay/version"
require "okay/warning_helpers"
require "pathname"

module Okay
  ##
  # An extremely simple templating engine.
  #
  # General usage:
  #
  #     template = Okay::Template.new("./templates")
  #     puts template.apply("some_template.html", {"some_key": "some value"})
  #     template.directory #=> "./templates"
  class Template
    include WarningHelpers

    attr_reader :directory

    ##
    # Create an Okay::Templates object.
    #
    # @param directory [String] Path of the directory containing the templates.
    def initialize(directory)
      @directory = directory
    end

    ##
    # Apply the template referenced by +template_name+ to +data+.
    #
    # @param template_name [String] Name of the template to use,
    #   relative to +@directory+ (as passed to +#initialize+).
    # @param data [Hash] Data to apply the template to.
    #
    # @return [String] Result of applying the template to +data+.
    def apply(template_name, data)
      template_file = Pathname.new(@directory).join(template_name)
      template = template_file.read

      # Silence warnings while applying the template, since we don't
      # generally care about unused keys.
      silence_warnings { Kernel.format(template, data) }
    end
  end
end
