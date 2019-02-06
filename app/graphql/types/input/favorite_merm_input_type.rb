module Types
  module Input
    FavoriteMermInputType = GraphQL::InputObjectType.define do
      name 'FavoriteMermInputType'
      description 'Properties for editing a Merm'

      argument :favorite, !types.Boolean
    end
  end
end
