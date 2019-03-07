# frozen_string_literal: true

module Mutations
  SignIn = GraphQL::Field.define do
    name 'SignIn'
    argument :email, !types.String
    argument :password, !types.String

    type Types::AuthType

    resolve -> (_obj, args, _ctx) {
      @user = User.find_for_database_authentication(email: args[:email])
      if @user
        if @user.valid_password?(args[:password])
          @user.reset_authentication_token! if @user.authentication_token_created_at < 1.days.ago
          id = @user.id
          authentication_token = @user.authentication_token
          first_name = @user.first_name
          last_name = @user.last_name
          return OpenStruct.new(
                               id: id,
                               first_name: first_name,
                               last_name: last_name,
                               authentication_token: authentication_token
          )
        else
          GraphQL::ExecutionError.new('Incorrect Email/Password')
        end
      else
        GraphQL::ExecutionError.new('User not registered on this application')
      end
    }
  end
end