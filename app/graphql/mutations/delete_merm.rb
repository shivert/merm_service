# frozen_string_literal: true

module Mutations
  DeleteMerm = GraphQL::Field.define do
    name 'DeleteMerm'
    argument :id, !types.ID

    type Types::MermType

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, args, ctx) {
      @merm = Merm.find(args[:id])

      if @merm
        if @merm.user == ctx[:current_user]
          @merm.delete
        else
          ## Trying to delete Tag on Someone else's Merm
          GraphQL::ExecutionError.new('Error: Unauthorized to Remove Merm')
        end
      else
        GraphQL::ExecutionError.new('Error: Unable to Find Merm')
      end
    })
  end
end