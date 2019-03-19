# frozen_string_literal: true

module Mutations
  CopyMerm = GraphQL::Field.define do
    name 'CopyMerm'
    argument :id, !types.ID

    type Types::MermType

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, args, ctx) {
      @merm = Merm.find(args[:id])

      if @merm

        if @merm.owner_id != ctx[:current_user].id
          @copied_merm = @merm.dup
          @copied_merm.owner_id = ctx[:current_user].id
          @copied_merm.category_id = nil

          if @copied_merm.save
            return @copied_merm
          else
            GraphQL::ExecutionError.new('Unable to Copy Merm')
          end
        else
          GraphQL::ExecutionError.new('Unable to Copy Your Own Merm')
        end
      else
        GraphQL::ExecutionError.new('Merm does not exist')
      end
    })
  end
end