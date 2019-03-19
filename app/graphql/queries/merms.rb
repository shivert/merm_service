module Queries
  Merms = GraphQL::Field.define do
    name 'merms'

    type types[Types::MermType]

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, _args, ctx) {
      Merm.where(:owner_id => ctx[:current_user].id)
    })
  end
end

