require "okay/graphql"

query = Okay::GraphQL.query {
  viewer {
    login
  }
}

headers = { bearer_token: ENV['DEMO_GITHUB_TOKEN'] }
results = query.submit!(:github, headers).or_raise!
puts results.from_json
