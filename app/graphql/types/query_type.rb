# frozen_string_literal: true

module Types
  QueryType = GraphQL::ObjectType.define do
    name 'MermQuery'

    field :merms, !types[Types::MermType] do
      resolve -> (obj, args, ctx) {
        Merm.all
      }
    end

  end
end