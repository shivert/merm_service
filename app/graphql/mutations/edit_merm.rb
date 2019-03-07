# frozen_string_literal: true

module Mutations
  EditMerm = GraphQL::Field.define do
    name 'EditMerm'
    argument :id, !types.ID
    argument :merm, !Types::Input::EditMermInputType

    type Types::MermType

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, args, ctx) {
      @merm = Merm.find_authorized(args[:id], ctx[:current_user])

      if @merm
        input = Hash[args[:merm].to_h.map {|k, v| [k.to_s.underscore.to_sym, v]}]

        if (@merm.update!(input))
          return @merm
        else
          # Failed update, return the errors to the client
          GraphQL::ExecutionError.new('Error: Unable to Update Merm')
        end
      else
        GraphQL::ExecutionError.new('Not authorized to edit this Merm')
      end
    })
  end
end