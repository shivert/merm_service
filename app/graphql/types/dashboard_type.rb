# frozen_string_literal: true

module Types
  DashboardType = GraphQL::ObjectType.define do
    name 'Dashboard'

    field :suggested, types[Types::MermType] do
      resolve -> (obj, args, ctx) {
        Merm.where(:owner_id => ctx[:current_user].id)
      }
    end

    field :favorites, types[Types::MermType] do
      resolve -> (obj, args, ctx) {
        Merm.where(:owner_id => ctx[:current_user].id, :favorite => true)
      }
    end

    field :unread, types[Types::MermType] do
      resolve -> (obj, args, ctx) { [] }
    end
  end
end
