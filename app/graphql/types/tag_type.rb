# frozen_string_literal: true

module Types
  TagType = GraphQL::ObjectType.define do
    name 'Tag'

    field :id, !types.ID, property: :id
    field :name, types.String, property: :name
    field :merm_id, !types.ID, property: :merm_id
    field :createdAt, !types.String, property: :created_at
    field :updatedAt, !types.String, property: :updated_at
  end
end
