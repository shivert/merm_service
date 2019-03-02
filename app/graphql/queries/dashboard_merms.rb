module Queries
  DashboardMerms = GraphQL::Field.define do
    name 'dashboardMerms'

    type Types::DashboardType
    description "Dashboard view of Merms"

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, _args, ctx) {
      {
          suggested: [],
          favorites: [],
          unread: []

      }
    })
  end
end

