module Queries
  Categories = GraphQL::Field.define do
    name 'categories'

    type types[Types::CategoryType]

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, _args, ctx) {
      Category.where(:owner_id => ctx[:current_user].id).custom
    })
  end
end

