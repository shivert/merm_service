module Mutations
  UpdateCategories = GraphQL::Field.define do
    name 'UpdateCategories'
    argument :data, Types::Input::CategoriesInputType

    type types[Types::CategoryType]

    resolve Resolvers::Helpers::AuthorizeUser.new(->(_obj, args, ctx) {
      categories = Hash[args['data'].to_h.map {|k, v| [k.to_s.underscore.to_sym, v]}][:categories]
      Category.sync(ctx[:current_user].id, categories)

      return Category.where(owner_id: ctx[:current_user].id)
    })
  end
end