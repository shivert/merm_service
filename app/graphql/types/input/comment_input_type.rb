module Types
  module Input
    CommentInputType = GraphQL::InputObjectType.define do
      name 'CommentInputType'
      description 'Properties for adding a new Comment'

      argument :content, !types.String
      argument :merm_id, !types.ID
      argument :author_id, !types.ID
    end
  end
end
