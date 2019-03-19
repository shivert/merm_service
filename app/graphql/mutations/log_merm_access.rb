# frozen_string_literal: true

module Mutations
  LogMermAccess = GraphQL::Field.define do
    name 'LogMermAccess'
    argument :id, !types.ID

    type Types::MermType

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, args, ctx) {
      @merm = Merm.find(args[:id])

      if @merm
        @merm.set_access_date

        if @merm.save
          return @merm
        else
          GraphQL::ExecutionError.new('Unable to update Merm')
        end
      else
        GraphQL::ExecutionError.new('Merm does not exist')
      end
    })
  end
end