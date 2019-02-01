module Mutations
  AddComment = GraphQL::Field.define do
    name 'AddComment'
    argument :commentDetails, !Types::Input::CommentInputType

    type Types::CommentType

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, args, ctx) {
      input = Hash[args['commentDetails'].to_h.map {|k, v| [k.to_s.underscore.to_sym, v]}]
      begin
        @comment = Comment.create!(input)
      rescue ActiveRecord::RecordInvalid => invalid
        GraphQL::ExecutionError.new("Invalid Attributes for #{invalid.record.class.name}: #{invalid.record.errors.full_messages.join(', ')}")
      end
    })
  end
end

