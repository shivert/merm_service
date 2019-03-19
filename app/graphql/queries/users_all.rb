module Queries
  UsersAll = GraphQL::Field.define do
    name 'usersAll'

    type types[Types::UserType]

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, _args, ctx) {
      User.all
    })
  end
end

