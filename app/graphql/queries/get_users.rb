module Queries
  GetUsers = GraphQL::Field.define do
    name 'getUsers'

    type types[Types::UserType]

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, _args, ctx) {
      User.all
    })
  end
end

