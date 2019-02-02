# frozen_string_literal: true

require "spec_helper"

require "okay/template"
require "pathname"

RSpec.describe Okay::Template do
  describe "#directory" do
    it "returns the directory that was provided" do
      expect(Okay::Template.new("./foo").directory).to eq("./foo")
    end
  end

  describe "#apply" do
    it "applies the template and returns the result" do
      template_dir = Pathname.new(__dir__).join("..", "data", "templates")
      template = Okay::Template.new(template_dir)

      expect(
        template.apply("example.html", {foo: "b", bar: "d"})
      ).to eq("a b c d e\n")
    end
  end
end
