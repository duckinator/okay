require "okay/graphql"

query = Okay::GraphQL.query {
  viewer {
    login
  }
}

headers = { bearer_token: "oh no, invalid bearer token!" }
results = query.submit!(:github, headers).or_raise!
puts results.from_json
