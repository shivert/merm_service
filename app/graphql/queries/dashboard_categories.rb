module Queries
  DashboardCategories = GraphQL::Field.define do
    name 'dashboardCategories'

    type types[Types::CategoryType]

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, _args, ctx) {
      Category.where(:owner_id => ctx[:current_user].id)
    })
  end
end

