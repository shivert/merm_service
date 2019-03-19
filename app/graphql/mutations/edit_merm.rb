# frozen_string_literal: true

module Mutations
  EditMerm = GraphQL::Field.define do
    name 'EditMerm'
    argument :id, !types.ID
    argument :merm, !Types::Input::EditMermInputType

    type Types::MermType

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, args, ctx) {
      @merm = Merm.find_authorized(args[:id], ctx[:current_user])
      @user = ctx[:current_user]

      input = Hash[args[:merm].to_h.map {|k, v| [k.to_s.underscore.to_sym, v]}]

      tags = input[:tags] ||= []
      shared_with = input[:shared_with] ||= []

      input.tap { |hs| hs.delete(:shared_with) }
      input.tap { |hs| hs.delete(:tags) }

      if @merm
        if (@merm.update(input))
          tags.each do |tag|
            tag = Hash[tag.map {|k, v| [k.to_s.to_sym, v]}]
            Tag.find_or_create_by(merm_id: @merm.id, owner_id: @user.id, name: tag[:name])
          end

          shared_with.each do |share|
            share = Hash[share.map {|k, v| [k.to_s.to_sym, v]}]
            Share.find_or_create_by(merm_id: @merm.id, sharer_id: @user.id, shared_with_id: share[:id])
          end

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