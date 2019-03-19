# frozen_string_literal: true

module Types
  ShareType = GraphQL::ObjectType.define do
    name 'Share'

    field :id, !types.ID, property: :id
    field :read, !types.Boolean, property: :read
    field :mermId, !types.ID, property: :merm_id
    field :sharer, Types::UserType do
      resolve -> (obj, args, ctx) { obj.sharer }
    end
    field :sharedWith, Types::UserType do
      resolve -> (obj, args, ctx) { obj.sharer }
    end
    field :createdAt, !types.String, property: :created_at
    field :updatedAt, !types.String, property: :updated_at
  end
end
