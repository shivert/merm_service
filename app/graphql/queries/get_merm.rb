# frozen_string_literal: true

module Queries
  GetMerms = GraphQL::Field.define do
    name 'Query'
    type Types::MermType

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, _args, ctx) {
      ctx[:current_user]
    })
  end
end
