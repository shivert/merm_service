module Types
  module Input
    MermInputType = GraphQL::InputObjectType.define do
      name 'MermInputType'
      description 'Properties for Creating a Merm'

      argument :name, !types.String
      argument :capturedText, !types.String
      argument :tags, !Types::Input::TagInputType
      argument :resourceUrl, !types.String
      argument :description, !types.String

    end
  end
end