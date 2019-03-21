# frozen_string_literal: true

module Types
  HistoryType = GraphQL::ObjectType.define do
    name 'History'

    field :id, !types.ID, property: :id
    field :mermId, !types.ID, property: :merm_id
    field :url, !types.String, property: :url
    field :visitTime, !types.String, property: :visit_time
    field :title, !types.String, property: :name
  end
end
