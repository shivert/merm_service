# frozen_string_literal: true

module Types
  MermType = GraphQL::ObjectType.define do
    name 'Merm'

    field :id, types.ID, property: :id
    field :name, types.String, property: :name
    field :source, types.String, property: :source
    field :favorite, types.Boolean, property: :favorite
    field :capturedText, types.String, property: :captured_text
    field :description, types.String, property: :description
    field :contentType, types.String, property: :content_type
    field :lastAccessed, types.String, property: :last_accessed
    field :createdAt, types.String, property: :created_at
    field :updatedAt, types.String, property: :updated_at
    field :expiryDate, types.String, property: :expiry_date
    field :resourceName, types.String, property: :resource_name
    field :resourceUrl, types.String, property: :resource_url
    field :category, Types::CategoryType do
      resolve -> (obj, args, ctx) { obj.category }
    end
    field :owner, Types::UserType do
      resolve -> (obj, args, ctx) { obj.user }
    end
    field :tags, types[Types::TagType] do
      resolve -> (obj, args, ctx) { obj.tags }
    end
    field :comments, types[Types::CommentType] do
      resolve -> (obj, args, ctx) { obj.comments }
    end
    field :shares, Types::ShareType do
      argument :user_id, types.ID
      resolve -> (obj, args, ctx) { obj.shares.find_by(shared_with_id: args[:user_id]) }
    end
    field :sharedWith, types[Types::UserType] do
      resolve -> (obj, args, ctx) { obj.shares.map(&:shared_with) }
    end
    field :history, types[Types::HistoryType] do
      resolve -> (obj, args, ctx) { obj.history.sort_by(&:visit_time) }
    end
  end
end

