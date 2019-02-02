# frozen_string_literal: true

require "okay/version"

module Okay
  module DefaultValue
    def self.nil?
      true
    end

    def self.inspect
      "default"
    end
  end

  def self.default
    DefaultValue
  end
end
