# frozen_string_literal: true

require "spec_helper"

require "okay/http"

# spec/http_helper.rb defines get(), post(), etc.
require "http_helper"

# NOTE: Requires a local copy of httpbin running, which can be done via
#       `docker run -p 80:80 kennethreitz/httpbin`
RSpec.describe Okay::HTTP do
  # HTTP 100 Continue -- not sure how to test, or if supported.
  # HTTP 101 Switching Protocols -- not sure how to test, or if supported.
  # HTTP 102 Processing -- not sure how to test, or if supported.

  it "handles 200 OK" do
    # expect(delete("/status/200").code).to eq "200"
    expect(get("/status/200").code).to eq "200"
    # expect(head("/status/200").code).to eq "200"
    # expect(options("/status/200").code).to eq "200"
    # expect(patch("/status/200").code).to eq "200"
    expect(post("/status/200").code).to eq "200"
    # expect(put("/status/200").code).to eq "200"
    # expect(trace("/status/200").code).to eq "200"
  end

  # 201 Created
  # 202 Accepted
  # 203 Non-authoritative Information
  # 204 No Content
  # 205 Reset Content
  # 206 Partial Content
  # 207 Multi-Status
  # 208 Already Reported
  # 226 IM Used

  # 300 Multiple Choices

  it "follows 301 Moved Permanently" do
    # expect(delete("/status/301").code).to eq "200"
    expect(get("/status/301").code).to eq "200"
    # expect(head("/status/301").code).to eq "200"
    # expect(options("/status/301").code).to eq "200"
    # expect(patch("/status/301").code).to eq "200"
    expect(post("/status/301").code).to eq "200"
    # expect(put("/status/301").code).to eq "200"
    # expect(trace("/status/301").code).to eq "200"
  end

  it "follows 302 Found" do
    # expect(delete("/status/302").code).to eq "200"
    expect(get("/status/302").code).to eq "200"
    # expect(head("/status/302").code).to eq "200"
    # expect(options("/status/302").code).to eq "200"
    # expect(patch("/status/302").code).to eq "200"
    expect(post("/status/302").code).to eq "200"
    # expect(put("/status/302").code).to eq "200"
    # expect(trace("/status/302").code).to eq "200"
  end

  it "follows 303 See Other" do
    # expect(delete("/status/303").code).to eq "200"
    expect(get("/status/303").code).to eq "200"
    # expect(head("/status/303").code).to eq "200"
    # expect(options("/status/303").code).to eq "200"
    # expect(patch("/status/303").code).to eq "200"
    expect(post("/status/303").code).to eq "200"
    # expect(put("/status/303").code).to eq "200"
    # expect(trace("/status/303").code).to eq "200"
  end

  # 304 Not Modified -- As far as I know, this library can't make
  #                     conditional requests. If it can, or this changes,
  #                     add tests here.

  # 305 Use Proxy -- deprecated in RFC7231.
  # https://tools.ietf.org/html/rfc7231#section-6.4.5

  it "follows 307 Temporary Redirect" do
    # expect(delete("/status/307").code).to eq "200"
    expect(get("/status/307").code).to eq "200"
    # expect(head("/status/307").code).to eq "200"
    # expect(options("/status/307").code).to eq "200"
    # expect(patch("/status/307").code).to eq "200"
    expect(post("/status/307").code).to eq "200"
    # expect(put("/status/307").code).to eq "200"
    # expect(trace("/status/307").code).to eq "200"

    # TODO: Test that POST is not changed to GET.
  end

  it "follows 308 Permanent Redirect" do
    url = "/status/308"

    # expect(delete(url).code).to eq "200"
    expect(get(url).code).to eq "200"
    # expect(head(url).code).to eq "200"
    # expect(options(url).code).to eq "200"
    # expect(patch(url).code).to eq "200"
    expect(post(url).code).to eq "200"
    # expect(put(url).code).to eq "200"
    # expect(trace(url).code).to eq "200"

    # p post(url)
    # TODO: Test that POST is not changed to GET.
  end

  # TODO: HTTP 400, 401, 402, 403 tests.

  it "handles 400 Bad Request" do
    #expect(delete("/status/400").code).to eq "400"
    expect(get("/status/400").code).to eq "400"
    #expect(head("/status/400").code).to eq "400"
    #expect(options("/status/400").code).to eq "400"
    #expect(patch("/status/400").code).to eq "400"
    expect(post("/status/400").code).to eq "400"
    #expect(put("/status/400").code).to eq "400"
    #expect(trace("/status/400").code).to eq "400"
  end

  it "handles 402 Payment Required" do
    # expect(delete("/status/402").code).to eq "402"
    expect(get("/status/402").code).to eq "402"
    # expect(head("/status/402").code).to eq "402"
    # expect(options("/status/402").code).to eq "402"
    # expect(patch("/status/402").code).to eq "402"
    expect(post("/status/402").code).to eq "402"
    # expect(put("/status/402").code).to eq "402"
    # expect(trace("/status/402").code).to eq "402"
  end

  it "handles 403 Forbidden" do
    # expect(delete("/status/403").code).to eq "403"
    expect(get("/status/403").code).to eq "403"
    # expect(head("/status/403").code).to eq "403"
    # expect(options("/status/403").code).to eq "403"
    # expect(patch("/status/403").code).to eq "403"
    expect(post("/status/403").code).to eq "403"
    # expect(put("/status/403").code).to eq "403"
    # expect(trace("/status/403").code).to eq "403"
  end

  it "handles 404 Not Found" do
    # expect(delete("/status/404").code).to eq "404"
    expect(get("/status/404").code).to eq "404"
    # expect(head("/status/404").code).to eq "404"
    # expect(options("/status/404").code).to eq "404"
    # expect(patch("/status/404").code).to eq "404"
    expect(post("/status/404").code).to eq "404"
    # expect(put("/status/404").code).to eq "404"
    # expect(trace("/status/404").code).to eq "404"
  end

  # TODO: HTTP 405-418, 421-429, 431, 444, 451, 499 tests.

  # TODO: HTTP 500-511, 599 tests.
end
