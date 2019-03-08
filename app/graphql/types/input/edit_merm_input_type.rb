module Types
  module Input
    EditMermInputType = GraphQL::InputObjectType.define do
      name 'EditMermInputType'
      description 'Properties for editing a Merm'

      # argument :name, !types.String,
      argument :name, types.String
      argument :resourceName, types.String
      argument :capturedText, types.String
      argument :resourceUrl, types.String
      argument :description, types.String
      argument :categoryId, types.ID
    end
  end
end
