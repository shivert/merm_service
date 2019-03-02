module Mutations
  AddTag = GraphQL::Field.define do
    name 'AddTag'
    argument :tagDetails, !Types::Input::TagInputType

    type Types::TagType

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, args, ctx) {
      input = Hash[args['tagDetails'].to_h.map {|k, v| [k.to_s.underscore.to_sym, v]}]

      @merm = Merm.find(input[:merm_id])
      if @merm
        if @merm.user == ctx[:current_user]
          begin
            @tag = Tag.create!(input)
          rescue ActiveRecord::RecordInvalid => invalid
            GraphQL::ExecutionError.new("Invalid Attributes for #{invalid.record.class.name}: #{invalid.record.errors.full_messages.join(', ')}")
          end
        else
          ## Trying to delete Tag on Someone else's Merm
          GraphQL::ExecutionError.new('Error: Unauthorized to Remove Tag')
        end
      else
        GraphQL::ExecutionError.new('Error: Unable to Find Merm')
      end
    })
  end
end