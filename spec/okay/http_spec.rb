# frozen_string_literal: true

require "spec_helper"

require "okay/http"

# spec/http_helper.rb defines get(), post(), etc.
require "http_helper"


# NOTE: Requires a local copy of httpbin running, which can be done via
#       `docker run -p 80:80 kennethreitz/httpbin`
RSpec.describe Okay::HTTP do
  it "handles 200 OK" do
    #expect(delete("/status/200").code).to eq "200"
    expect(get("/status/200").code).to eq "200"
    #expect(head("/status/200").code).to eq "200"
    #expect(options("/status/200").code).to eq "200"
    #expect(patch("/status/200").code).to eq "200"
    expect(post("/status/200").code).to eq "200"
    #expect(put("/status/200").code).to eq "200"
    #expect(trace("/status/200").code).to eq "200"
  end

  it "handles 404 Not Found" do
    #expect(delete("/status/404").code).to eq "404"
    expect(get("/status/404").code).to eq "404"
    #expect(head("/status/404").code).to eq "404"
    #expect(options("/status/404").code).to eq "404"
    #expect(patch("/status/404").code).to eq "404"
    expect(post("/status/404").code).to eq "404"
    #expect(put("/status/404").code).to eq "404"
    #expect(trace("/status/404").code).to eq "404"
  end

  it "follows 301 Moved Permanently" do
    #expect(delete("/status/301").code).to eq "200"
    expect(get("/status/301").code).to eq "200"
    #expect(head("/status/301").code).to eq "200"
    #expect(options("/status/301").code).to eq "200"
    #expect(patch("/status/301").code).to eq "200"
    expect(post("/status/301").code).to eq "200"
    #expect(put("/status/301").code).to eq "200"
    #expect(trace("/status/301").code).to eq "200"
  end
end
