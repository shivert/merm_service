# frozen_string_literal: true

module Mutations
  DeleteTag = GraphQL::Field.define do
    name 'DeleteTag'
    argument :id, !types.ID

    type Types::TagType

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, args, ctx) {
      @tag = Tag.find(args[:id])

      if @tag
        @merm = @tag.merm
        if @merm
          if @merm.user == ctx[:current_user]
            @tag.delete
          else
            ## Trying to delete Tag on Someone else's Merm
            GraphQL::ExecutionError.new('Error: Unauthorized to Remove Tag')
          end
        else
          GraphQL::ExecutionError.new('Error: Unable to Find Merm')
        end
      else
        GraphQL::ExecutionError.new('Error: Unable to Find Tag')
      end
    })
  end
end