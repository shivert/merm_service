module Queries
  Tags = GraphQL::Field.define do
    name 'tags'

    type types[Types::TagType]

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, _args, ctx) {
      Tag.where(:owner_id => ctx[:current_user].id).uniq(&:name).sort_by(&:name)
    })
  end
end

