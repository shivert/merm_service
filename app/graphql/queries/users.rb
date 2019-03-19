module Queries
  Users = GraphQL::Field.define do
    name 'users'

    type types[Types::UserType]

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, _args, ctx) {
      User.where.not(:id => ctx[:current_user].id)
    })
  end
end

