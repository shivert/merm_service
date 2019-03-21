module Types
  module Input
    MermInputType = GraphQL::InputObjectType.define do
      name 'MermInputType'
      description 'Properties for Creating a Merm'

      argument :name, !types.String
      argument :categoryId, types.ID
      argument :expiryDate, types.String
      argument :capturedText, types.String
      argument :tags, types[types.String]
      argument :historyBeforeMerm, types[Types::Input::HistoryInputType]
      argument :source, types.String
      argument :resourceName, types.String
      argument :resourceUrl, !types.String
      argument :description, types.String

    end
  end
end