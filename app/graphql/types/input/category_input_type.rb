module Types
  module Input
    CategoryInputType = GraphQL::InputObjectType.define do
      name 'CategoryInputType'
      description 'Properties for updating Categories'

      argument :id, types.String
      argument :key, types.String
      argument :name, types.String
      argument :rank, types.Int
    end
  end
end
