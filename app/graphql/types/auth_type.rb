# frozen_string_literal: true

module Types
  AuthType = GraphQL::ObjectType.define do
    name 'AuthType'

    field :authenticationToken, !types.String, property: :authentication_token
    field :firstName, !types.String, property: :first_name
    field :lastName, !types.String, property: :last_name
  end
end
