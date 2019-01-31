# frozen_string_literal: true

module Types
  UserType = GraphQL::ObjectType.define do
    name 'User'
    description 'A User'

    field :id, !types.ID, property: :id
    field :lastName, !types.String, property: :last_name
    field :firstName, !types.String, property: :first_name
    field :email, !types.String
    field :authenticationToken, !types.String, property: :authentication_token

    field :name, !types.String do
      resolve -> (obj, args, ctx) { obj.first_name + " " + obj.last_name }
    end

  end
end