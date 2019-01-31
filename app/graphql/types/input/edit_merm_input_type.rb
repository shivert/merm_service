module Types
  module Input
    EditMermInputType = GraphQL::InputObjectType.define do
      name 'EditMermInputType'
      description 'Properties for editing a Merm'

      argument :favorite, !types.Boolean
    end
  end
end
