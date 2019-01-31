Query = GraphQL::ObjectType.define do
  name 'Query'

  # Add root-level fields here.
  # They will be entry points for queries on your schema.
  field :allMerms do
    type types[Types::MermType]
    description "A list of all the Merms"

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, _args, ctx) {
      Merm.where(:owner_id => ctx[:current_user].id)
    })
  end

  field :dashboardMerms do
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

  field :merm do
    type Types::MermType
    description "Return a Merm"
    argument :id, !types.ID
    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, _args, ctx) {
      Merm.find(_args[:id])
    })
  end
end
