module Mutations
  CreateMerm = GraphQL::Field.define do
    name 'CreateMerm'
    argument :mermDetails, !Types::Input::MermInputType

    type Types::MermType

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, args, ctx) {
      input = Hash[args['mermDetails'].to_h.map {|k, v| [k.to_s.underscore.to_sym, v]}]
      tags = input[:tags] ||= []
      history = input[:history_before_merm] ||= []
      input.tap { |hs| hs.delete(:tags); hs.delete(:history_before_merm) }

      begin
        @user = User.find(ctx[:current_user].id)

        if @user
          @merm = @user.merms.create(input)

          if @merm.save!
            tags.each do |name|
              Tag.create!(name: name, merm_id: @merm.id, owner_id: @user.id)
            end

            history.each do |h|
              h = Hash[h.map {|k, v| [k.to_s.underscore.to_sym, v]}]
              History.create!(merm_id: @merm.id, url: h[:url], visit_time: h[:last_visit_time], name: h[:title] )
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

