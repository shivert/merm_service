module Queries
  GetMerm = GraphQL::Field.define do
    name 'getMerm'
    description "Return a Merm"

    argument :id, !types.ID

    type Types::MermType

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, _args, ctx) {
      Merm.find(_args[:id])
    })
  end
end

