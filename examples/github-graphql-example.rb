require "okay/graphql"

query = Okay::GraphQL.query {
  viewer {
    login
  }
}
  
results = query.submit!(:github, {bearer_token: ENV['DEMO_GITHUB_TOKEN']}).or_raise!
puts results.from_json
