module Types
  module Input
    HistoryInputType = GraphQL::InputObjectType.define do
      name 'HistoryInputType'
      description 'Properties for adding a history'

      argument :merm_id, types.ID
      argument :url, !types.String
      argument :lastVisitTime, !types.String
      argument :title, !types.String
    end
  end
end
