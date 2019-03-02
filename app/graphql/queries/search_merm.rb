module Queries
  SearchMerm = GraphQL::Field.define do
    name "SearchMerm"
    description "Search For a Merm"

    type types[Types::MermType]

    argument :queryString, !types.String

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, _args, ctx) {
      Merm.search(_args[:queryString], ctx[:current_user])
    })
  end
end

