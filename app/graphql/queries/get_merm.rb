module Queries
  GetMerm = GraphQL::Field.define do
    name 'getMerm'
    description "Return a Merm"

    argument :id, !types.ID
    argument :shared, types.Boolean

    type Types::MermType

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, _args, ctx) {
      @merm = Merm.find(_args[:id])

      if (_args[:shared])
       @merm.shares.find_by(shared_with_id: ctx[:current_user].id).set_viewed
      end

      return @merm
    })
  end
end

