module Queries
  GetTags = GraphQL::Field.define do
    name 'getTags'

    type types[Types::TagType]

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, _args, ctx) {
      Tag.all
    })
  end
end

