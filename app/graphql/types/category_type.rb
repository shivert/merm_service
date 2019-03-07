# frozen_string_literal: true

module Types
  CategoryType = GraphQL::ObjectType.define do
    name 'Category'

    field :id, !types.ID, property: :id
    field :name, !types.String, property: :name
    field :rank, !types.Int, property: :rank
    field :user, Types::UserType do
      resolve -> (obj, args, ctx) { obj.user }
    end
    field :custom, !types.Boolean, property: :custom
    field :createdAt, !types.String, property: :created_at
    field :updatedAt, !types.String, property: :updated_at
  end
end
