Mutation = GraphQL::ObjectType.define do
  name 'Mutation'
  field :signIn, Mutations::SignIn
  field :signUp, Mutations::RegisterUser
  field :editMerm, Mutations::EditMerm
  field :addComment, Mutations::AddComment
end
