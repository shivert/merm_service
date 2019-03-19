module Types
  module Input
    ShareInputType = GraphQL::InputObjectType.define do
      name 'ShareInputType'
      description 'Properties for sharing a Merm With A User'

      argument :id, types.ID
      argument :name, types.String
    end
  end
end
