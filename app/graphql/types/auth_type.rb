# frozen_string_literal: true

module Types
  AuthType = GraphQL::ObjectType.define do
    name 'AuthType'

    field :authenticationToken, !types.String, property: :authentication_token
    field :first_name, !types.String, property: :first_name
    field :last_name, !types.String, property: :last_name
  end
end
