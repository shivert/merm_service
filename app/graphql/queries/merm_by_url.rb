module Queries
  MermByUrl = GraphQL::Field.define do
    name 'MermByUrl'
    description "Search for a Merm by URL"

    argument :url, !types.String

    type Types::MermType

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, _args, ctx) {
      Merm.find_by(owner_id: ctx[:current_user].id, resource_url: _args[:url])
    })
  end
end

