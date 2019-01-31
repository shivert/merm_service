# frozen_string_literal: true

module Types
  CommentType = GraphQL::ObjectType.define do
    name 'Comment'

    field :id, !types.ID, property: :id
    field :content, !types.String, property: :content
    field :merm_id, !types.ID, property: :merm_id
    field :author, Types::UserType do
      resolve -> (obj, args, ctx) { obj.user }
    end
    field :createdAt, !types.String, property: :created_at
    field :updatedAt, !types.String, property: :updated_at
  end
end
