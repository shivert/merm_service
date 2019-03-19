module Queries
  SharedMerms = GraphQL::Field.define do
    name 'sharedMerms'

    type types[Types::MermType]

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, _args, ctx) {
      ctx[:current_user].shared_with_merms
    })
  end
end

