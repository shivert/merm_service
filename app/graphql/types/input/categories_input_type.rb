module Types
  module Input
    CategoriesInputType = GraphQL::InputObjectType.define do
      name 'CategoriesInputType'
      description 'Properties for updating Categories'

      argument :categories, types[Types::Input::CategoryInputType]
    end
  end
end
