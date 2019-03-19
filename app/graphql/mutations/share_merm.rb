# frozen_string_literal: true

module Mutations
  ShareMerm = GraphQL::Field.define do
    name 'ShareMerm'
    argument :id, !types.ID
    argument :users, types[!types.ID]

    type Types::MermType

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, args, ctx) {
      @merm = Merm.find_authorized(args[:id], ctx[:current_user])

      if @merm
        if (@merm.share(ctx[:current_user].id, args[:users]))
          return @merm
        else
          # Failed update, return the errors to the client
          GraphQL::ExecutionError.new('Error: Unable to Share Merm')
        end
      else
        GraphQL::ExecutionError.new('Not authorized to share this Merm')
      end
    })
  end
end