module Mutations
  CreateMerm = GraphQL::Field.define do
    name 'CreateMerm'
    argument :mermDetails, !Types::Input::MermInputType

    type Types::MermType

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, args, ctx) {
      input = Hash[args['mermDetails'].to_h.map {|k, v| [k.to_s.underscore.to_sym, v]}]
      tags = input[:tags] ||= []
      input.tap { |hs| hs.delete(:tags) }

      begin
        @user = User.find(ctx[:current_user].id)

        if @user
          @merm = @user.merms.create(input)

          if @merm.save
            tags.each do |name|
              Tag.create!(name: name, merm_id: @merm.id)
            end
          end
        end

        return @merm

      rescue ActiveRecord::RecordInvalid => invalid
        GraphQL::ExecutionError.new("Invalid Attributes for #{invalid.record.class.name}: #{invalid.record.errors.full_messages.join(', ')}")
      end
    })
  end
end

