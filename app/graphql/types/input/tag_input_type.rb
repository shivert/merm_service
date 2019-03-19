module Types
  module Input
    TagInputType = GraphQL::InputObjectType.define do
      name 'TagInputType'
      description 'Properties for adding a new Tag'

      argument :id, types.ID
      argument :name, types.String
      argument :merm_id , types.ID
    end
  end
end
